import { Gio, GLib } from "astal"
import { Variable } from "astal"

export interface NiriWorkspace {
  id: number
  name: string
  output: string
  is_active: boolean
  is_focused: boolean
}

export interface NiriMonitor {
  name: string
  make: string
  model: string
  width: number
  height: number
  refresh_rate: number
  transform: string
  focused: boolean
}

class NiriService {
  private static _instance: NiriService | null = null

  readonly focusedMonitor = Variable<NiriMonitor | null>(null)
  readonly focusedWorkspace = Variable<NiriWorkspace | null>(null)
  readonly workspaces = Variable<NiriWorkspace[]>([])
  readonly monitors = Variable<NiriMonitor[]>([])

  private constructor() {
    this.refresh()
    this.startEventStream()
  }

  static get_default(): NiriService {
    if (!this._instance) {
      this._instance = new NiriService()
    }
    return this._instance
  }

  private exec(cmd: string): string {
    try {
      const proc = Gio.Subprocess.new(
        ["niri", "msg", ...cmd.split(" ")],
        Gio.SubprocessFlags.STDOUT_PIPE | Gio.SubprocessFlags.STDERR_PIPE
      )
      const [, stdout] = proc.communicate_utf8(null, null)
      return stdout || ""
    } catch (e) {
      console.error(`Failed to execute niri msg ${cmd}:`, e)
      return ""
    }
  }

  private async execAsync(cmd: string): Promise<string> {
    return new Promise((resolve, reject) => {
      try {
        const proc = Gio.Subprocess.new(
          ["niri", "msg", ...cmd.split(" ")],
          Gio.SubprocessFlags.STDOUT_PIPE | Gio.SubprocessFlags.STDERR_PIPE
        )
        proc.communicate_utf8_async(null, null, (_, result) => {
          try {
            const [, stdout] = proc.communicate_utf8_finish(result)
            resolve(stdout || "")
          } catch (e) {
            reject(e)
          }
        })
      } catch (e) {
        reject(e)
      }
    })
  }

  private refresh() {
    this.refreshWorkspaces()
    this.refreshMonitors()
  }

  private refreshWorkspaces() {
    try {
      const output = this.exec("workspaces")
      const data = JSON.parse(output) as any[]
      
      const workspaces: NiriWorkspace[] = data.map((ws) => ({
        id: ws.id,
        name: ws.name,
        output: ws.output || "",
        is_active: ws.is_active || false,
        is_focused: ws.is_focused || false,
      }))

      this.workspaces.set(workspaces)
      
      const focused = workspaces.find((ws) => ws.is_focused)
      this.focusedWorkspace.set(focused || null)
    } catch (e) {
      console.error("Failed to parse workspaces:", e)
    }
  }

  private refreshMonitors() {
    try {
      const output = this.exec("outputs")
      const data = JSON.parse(output) as any[]
      
      const monitors: NiriMonitor[] = data.map((mon) => ({
        name: mon.name,
        make: mon.make || "",
        model: mon.model || "",
        width: mon.current_mode?.width || 0,
        height: mon.current_mode?.height || 0,
        refresh_rate: mon.current_mode?.refresh_rate || 0,
        transform: mon.transform || "normal",
        focused: mon.focused || false,
      }))

      this.monitors.set(monitors)
      
      const focused = monitors.find((mon) => mon.focused)
      this.focusedMonitor.set(focused || null)
    } catch (e) {
      console.error("Failed to parse outputs:", e)
    }
  }

  private startEventStream() {
    try {
      const proc = Gio.Subprocess.new(
        ["niri", "msg", "event-stream"],
        Gio.SubprocessFlags.STDOUT_PIPE
      )

      const stream = proc.get_stdout_pipe()
      if (!stream) return

      const dis = new Gio.DataInputStream({
        base_stream: stream,
      })

      this.readLine(dis)
    } catch (e) {
      console.error("Failed to start event stream:", e)
    }
  }

  private readLine(stream: Gio.DataInputStream) {
    stream.read_line_async(GLib.PRIORITY_DEFAULT, null, (_, result) => {
      try {
        const [line] = stream.read_line_finish_utf8(result)
        if (line) {
          this.handleEvent(line)
          this.readLine(stream)
        }
      } catch (e) {
        console.error("Error reading event stream:", e)
      }
    })
  }

  private handleEvent(line: string) {
    // Skip empty lines
    if (!line || line.trim() === "") {
      return
    }

    try {
      // Parse text-based event format
      // Examples:
      // "Workspace focused: 2"
      // "Window focus changed: Some(36)"
      // "Overview toggled: false"
      // "Config loaded successfully"
      
      if (line.includes("Workspace focused:")) {
        const match = line.match(/Workspace focused:\s*(\d+)/)
        if (match) {
          const workspaceId = parseInt(match[1])
          // Refresh to get updated focus state
          this.refreshWorkspaces()
        }
      } else if (line.includes("Window focus changed:")) {
        // Window focus might affect workspace state
        this.refreshWorkspaces()
      } else if (line.includes("Workspace") || line.includes("workspace")) {
        // Any other workspace event
        this.refreshWorkspaces()
      } else if (line.includes("Output") || line.includes("output")) {
        // Monitor/output events
        this.refreshMonitors()
        this.refreshWorkspaces()
      } else if (line.includes("Config loaded")) {
        // Config reload - refresh everything
        this.refresh()
      }
    } catch (e) {
      console.error("Failed to handle event:", e, "Line:", line)
    }
  }

  message(cmd: string) {
    this.exec(cmd)
  }

  async messageAsync(cmd: string): Promise<string> {
    return this.execAsync(cmd)
  }

  focusWorkspace(name: string) {
    this.message(`action focus-workspace "${name}"`)
  }

  async focusWorkspaceAsync(name: string) {
    await this.messageAsync(`action focus-workspace "${name}"`)
  }
}

export default NiriService.get_default()
