import { App, Gdk, Gtk } from "astal/gtk3"
import { timeout } from "astal"
import style from "./style.scss"
import Bar from "./widget/Bar"

function main() {
    const bars = new Map<Gdk.Monitor, Gtk.Window[]>()

    // initialize
    for (const gdkmonitor of App.get_monitors()) {
        bars.set(gdkmonitor, Bar(gdkmonitor))
    }

    App.connect("monitor-added", () => {
        // Add a timeout so that monitor properties have time to be initialized
        timeout(1000, () => {
            App.get_monitors().map(m => {
                if (!bars.has(m)) {
                    console.log("New bar on monitor " + m.model);
                    bars.set(m, Bar(m))
                }
            })
        })
    })

    App.connect("monitor-removed", (_, gdkmonitor) => {
        bars.get(gdkmonitor)?.map(b => b.destroy())
        bars.delete(gdkmonitor)
    })
}

App.start({
    instanceName: "bar",
    icons: `/usr/share/icons/Adwaita/symbolic/actions/`,
    css: style,
    main
})
