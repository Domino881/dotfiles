import { App, Gdk, Gtk  } from "astal/gtk3"
import { timeout } from "astal"
import style from "./style.scss"
import OSD from "./osd/OSD"

function main() {
    const osds = new Map<Gdk.Monitor, Gtk.Widget>()

    // initialize
    for (const gdkmonitor of App.get_monitors()) {
        osds.set(gdkmonitor, OSD(gdkmonitor))
    }

    App.connect("monitor-added", (_, gdkmonitor) => {
        osds.set(gdkmonitor, OSD(gdkmonitor))
        // Add a timeout so that monitor properties have time to be initialized
        timeout(1000, () => osds.set(gdkmonitor, OSD(gdkmonitor)))
    })

    App.connect("monitor-removed", (_, gdkmonitor) => {
        osds.get(gdkmonitor)?.destroy()
        osds.delete(gdkmonitor)
    })
}

App.start({
    instanceName: "osd",
    css: style,
    main
})
