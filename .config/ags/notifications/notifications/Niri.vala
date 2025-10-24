namespace AstalNiri {
    public class Niri : Object {
        private static Niri instance;
        private SocketStream stream;
        private DataInputStream reader;
        private HashTable<string, Monitor> monitors;
        private HashTable<string, Workspace> workspaces;
        
        public string focused_monitor_name { get; private set; default = ""; }
        public string focused_workspace_name { get; private set; default = ""; }
        
        public signal void event(string event_name, string data);
        public signal void monitor_added(Monitor monitor);
        public signal void monitor_removed(string monitor_name);
        public signal void workspace_added(Workspace workspace);
        public signal void workspace_removed(string workspace_name);
        public signal void focused_monitor_changed(Monitor? monitor);
        public signal void focused_workspace_changed(Workspace? workspace);
        
        private Niri() {
            monitors = new HashTable<string, Monitor>(str_hash, str_equal);
            workspaces = new HashTable<string, Workspace>(str_hash, str_equal);
            
            try {
                init_connection();
                refresh_state();
                start_event_stream();
            } catch (Error e) {
                warning("Failed to initialize Niri connection: %s", e.message);
            }
        }
        
        public static Niri get_default() {
            if (instance == null) {
                instance = new Niri();
            }
            return instance;
        }
        
        private void init_connection() throws Error {
            // Execute niri msg event-stream
            int stdin_fd, stdout_fd;
            Pid child_pid;
            
            Process.spawn_async_with_pipes(
                null,
                {"niri", "msg", "event-stream"},
                null,
                SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
                null,
                out child_pid,
                out stdin_fd,
                out stdout_fd,
                null
            );
            
            var output_stream = new UnixInputStream(stdout_fd, true);
            reader = new DataInputStream(output_stream);
        }
        
        private void refresh_state() throws Error {
            // Get initial workspaces
            string workspaces_output;
            Process.spawn_command_line_sync(
                "niri msg workspaces",
                out workspaces_output,
                null,
                null
            );
            parse_workspaces(workspaces_output);
            
            // Get initial outputs (monitors)
            string outputs_output;
            Process.spawn_command_line_sync(
                "niri msg outputs",
                out outputs_output,
                null,
                null
            );
            parse_outputs(outputs_output);
        }
        
        private void parse_workspaces(string json_str) {
            try {
                var parser = new Json.Parser();
                parser.load_from_data(json_str);
                var root = parser.get_root().get_array();
                
                workspaces.remove_all();
                
                root.foreach_element((array, index, node) => {
                    var obj = node.get_object();
                    var id = obj.get_int_member("id");
                    var name = obj.get_string_member("name");
                    var output = obj.has_member("output") ? obj.get_string_member("output") : "";
                    var is_active = obj.get_boolean_member("is_active");
                    var is_focused = obj.get_boolean_member("is_focused");
                    
                    var workspace = new Workspace((int)id, name, output);
                    workspace.is_active = is_active;
                    workspace.is_focused = is_focused;
                    
                    workspaces.set(name, workspace);
                    
                    if (is_focused) {
                        focused_workspace_name = name;
                    }
                });
            } catch (Error e) {
                warning("Failed to parse workspaces: %s", e.message);
            }
        }
        
        private void parse_outputs(string json_str) {
            try {
                var parser = new Json.Parser();
                parser.load_from_data(json_str);
                var root = parser.get_root().get_array();
                
                monitors.remove_all();
                
                root.foreach_element((array, index, node) => {
                    var obj = node.get_object();
                    var name = obj.get_string_member("name");
                    var make = obj.has_member("make") ? obj.get_string_member("make") : "";
                    var model = obj.has_member("model") ? obj.get_string_member("model") : "";
                    var focused = obj.get_boolean_member("focused");
                    
                    var monitor = new Monitor(name, make, model);
                    monitor.focused = focused;
                    
                    // Parse modes
                    if (obj.has_member("modes")) {
                        var modes_array = obj.get_array_member("modes");
                        modes_array.foreach_element((arr, idx, mode_node) => {
                            var mode_obj = mode_node.get_object();
                            var width = (int)mode_obj.get_int_member("width");
                            var height = (int)mode_obj.get_int_member("height");
                            var refresh = mode_obj.get_double_member("refresh_rate");
                            var is_preferred = mode_obj.has_member("is_preferred") && 
                                             mode_obj.get_boolean_member("is_preferred");
                            
                            var mode = new MonitorMode(width, height, refresh, is_preferred);
                            monitor.add_mode(mode);
                        });
                    }
                    
                    // Get current mode
                    if (obj.has_member("current_mode")) {
                        var current = obj.get_object_member("current_mode");
                        var width = (int)current.get_int_member("width");
                        var height = (int)current.get_int_member("height");
                        var refresh = current.get_double_member("refresh_rate");
                        
                        monitor.width = width;
                        monitor.height = height;
                        monitor.refresh_rate = refresh;
                    }
                    
                    // Parse transform
                    if (obj.has_member("transform")) {
                        monitor.transform = obj.get_string_member("transform");
                    }
                    
                    monitors.set(name, monitor);
                    
                    if (focused) {
                        focused_monitor_name = name;
                    }
                });
            } catch (Error e) {
                warning("Failed to parse outputs: %s", e.message);
            }
        }
        
        private void start_event_stream() {
            read_event_stream.begin();
        }
        
        private async void read_event_stream() {
            try {
                while (true) {
                    var line = yield reader.read_line_async(Priority.DEFAULT, null);
                    if (line == null) break;
                    
                    handle_event(line);
                }
            } catch (Error e) {
                warning("Error reading event stream: %s", e.message);
            }
        }
        
        private void handle_event(string json_str) {
            try {
                var parser = new Json.Parser();
                parser.load_from_data(json_str);
                var root = parser.get_root().get_object();
                
                if (!root.has_member("event")) return;
                
                var event_name = root.get_string_member("event");
                event(event_name, json_str);
                
                switch (event_name) {
                    case "WorkspaceActivated":
                        handle_workspace_activated(root);
                        break;
                    case "WorkspacesChanged":
                        handle_workspaces_changed();
                        break;
                    case "WorkspaceAdded":
                        handle_workspace_added(root);
                        break;
                    case "WorkspaceRemoved":
                        handle_workspace_removed(root);
                        break;
                    case "OutputConnected":
                        handle_output_connected(root);
                        break;
                    case "OutputDisconnected":
                        handle_output_disconnected(root);
                        break;
                    case "OutputFocused":
                        handle_output_focused(root);
                        break;
                }
            } catch (Error e) {
                warning("Failed to handle event: %s", e.message);
            }
        }
        
        private void handle_workspace_activated(Json.Object obj) {
            if (!obj.has_member("id") || !obj.has_member("focused")) return;
            
            var workspace_id = (int)obj.get_int_member("id");
            var focused = obj.get_boolean_member("focused");
            
            if (focused) {
                // Find workspace by ID
                workspaces.foreach((name, ws) => {
                    if (ws.id == workspace_id) {
                        focused_workspace_name = name;
                        focused_workspace_changed(ws);
                    }
                });
            }
        }
        
        private void handle_workspaces_changed() {
            // Refresh workspace state
            try {
                string output;
                Process.spawn_command_line_sync(
                    "niri msg workspaces",
                    out output,
                    null,
                    null
                );
                parse_workspaces(output);
            } catch (Error e) {
                warning("Failed to refresh workspaces: %s", e.message);
            }
        }
        
        private void handle_workspace_added(Json.Object obj) {
            if (!obj.has_member("workspace")) return;
            
            var ws_obj = obj.get_object_member("workspace");
            var id = (int)ws_obj.get_int_member("id");
            var name = ws_obj.get_string_member("name");
            var output = ws_obj.has_member("output") ? ws_obj.get_string_member("output") : "";
            
            var workspace = new Workspace(id, name, output);
            workspaces.set(name, workspace);
            workspace_added(workspace);
        }
        
        private void handle_workspace_removed(Json.Object obj) {
            if (!obj.has_member("id")) return;
            
            var id = (int)obj.get_int_member("id");
            
            // Find and remove workspace
            string? removed_name = null;
            workspaces.foreach((name, ws) => {
                if (ws.id == id) {
                    removed_name = name;
                }
            });
            
            if (removed_name != null) {
                workspaces.remove(removed_name);
                workspace_removed(removed_name);
            }
        }
        
        private void handle_output_connected(Json.Object obj) {
            handle_workspaces_changed();
            
            try {
                string output;
                Process.spawn_command_line_sync(
                    "niri msg outputs",
                    out output,
                    null,
                    null
                );
                parse_outputs(output);
            } catch (Error e) {
                warning("Failed to refresh outputs: %s", e.message);
            }
        }
        
        private void handle_output_disconnected(Json.Object obj) {
            if (!obj.has_member("output")) return;
            
            var output_name = obj.get_string_member("output");
            
            if (monitors.contains(output_name)) {
                monitors.remove(output_name);
                monitor_removed(output_name);
            }
        }
        
        private void handle_output_focused(Json.Object obj) {
            if (!obj.has_member("output")) return;
            
            var output_name = obj.get_string_member("output");
            
            // Update focus state
            monitors.foreach((name, mon) => {
                mon.focused = (name == output_name);
            });
            
            focused_monitor_name = output_name;
            
            var monitor = monitors.get(output_name);
            if (monitor != null) {
                focused_monitor_changed(monitor);
            }
        }
        
        public Monitor? get_focused_monitor() {
            if (focused_monitor_name == "") return null;
            return monitors.get(focused_monitor_name);
        }
        
        public Workspace? get_focused_workspace() {
            if (focused_workspace_name == "") return null;
            return workspaces.get(focused_workspace_name);
        }
        
        public List<Monitor> get_monitors() {
            var list = new List<Monitor>();
            monitors.foreach((name, monitor) => {
                list.append(monitor);
            });
            return list;
        }
        
        public List<Workspace> get_workspaces() {
            var list = new List<Workspace>();
            workspaces.foreach((name, workspace) => {
                list.append(workspace);
            });
            return list;
        }
        
        public Monitor? get_monitor(string name) {
            return monitors.get(name);
        }
        
        public Workspace? get_workspace(string name) {
            return workspaces.get(name);
        }
        
        public void message(string command) throws Error {
            string output;
            int exit_status;
            
            Process.spawn_command_line_sync(
                @"niri msg $command",
                out output,
                null,
                out exit_status
            );
            
            if (exit_status != 0) {
                throw new IOError.FAILED(@"Command failed with exit code $exit_status");
            }
        }
        
        public async string message_async(string command) throws Error {
            string output;
            int exit_status;
            
            yield Process.spawn_command_line_async(
                @"niri msg $command",
                out output,
                null,
                out exit_status
            );
            
            if (exit_status != 0) {
                throw new IOError.FAILED(@"Command failed with exit code $exit_status");
            }
            
            return output;
        }
    }
}
