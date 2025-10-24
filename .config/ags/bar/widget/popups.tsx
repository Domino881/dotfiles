import { bind, Binding, Variable } from "astal";
import Wp from "gi://AstalWp";
import Network from "gi://AstalNetwork";
import Bluetooth from "gi://AstalBluetooth";
import { Astal, Gdk, Gtk } from "astal/gtk3";
import {
    Box,
    Window,
    Label,
    Overlay,
    Revealer,
    Icon,
    Button,
} from "astal/gtk3/widget";

export enum PopupType {
    NONE,
    BLUETOOTH,
    AUDIO,
    WIFI,
}
function popupWifi({ visible }: { visible: Binding<boolean> }) {
    const network = Network.get_default();
    const wifi = bind(network, "wifi");
    bind(wifi).as((wifi) =>
        wifi.accessPoints.map((ap) => print(ap.ssid)),
    );

    return new Revealer({
        revealChild: visible,
        child: new Box({
            className: "popupWindow",
            orientation: Gtk.Orientation.VERTICAL,
            children: bind(wifi).as((wifi) =>
                wifi.accessPoints.map(
                    (ap) =>
                        new Label({
                            label:
                                ap.ssid +
                                ": " +
                                ap.strength.toString(),
                        }),
                ),
            ),
        }),
    });
}
function popupBluetooth({ visible }: { visible: Binding<boolean> }) {
    const bluetooth = Bluetooth.get_default();

    return new Revealer({
        revealChild: visible,
        child: new Box({
            className: "popupWindow",
            children: bind(bluetooth, "devices").as((devices) =>
                devices.map((d) => new Label({label: d.name + "\n" + d.address + "\n" + d.appearance
                + "\n" + d.class + "\n" + d.icon + "\n" + d.rssi + "\n" + d.paired })),
            ),
        }),
    });
}
function popupAudio({ visible }: { visible: Binding<boolean> }) {
    const wp = Wp.get_default();

    return new Revealer({
        className: "popupWindow",
        revealChild: visible,
        child: new Box(
            { orientation: Gtk.Orientation.VERTICAL },
            new Label({ label: "audio" }),
            wp?.audio.speakers.map(
                (d) => new Label({ label: d.name }),
            ),
        ),
    });
}

export default function mainPopup({
    gdkmonitor,
    popupType,
}: {
    gdkmonitor: Gdk.Monitor;
    popupType: Variable<PopupType>;
}) {
    return [
        new Window(
            {
                exclusivity: Astal.Exclusivity.EXCLUSIVE,
                layer: Astal.Layer.OVERLAY,
                gdkmonitor: gdkmonitor,
                anchor:
                    Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT,
            },
            new Box(
                {
                    orientation: Gtk.Orientation.VERTICAL,
                },
                popupBluetooth({
                    visible: bind(popupType).as(
                        (pt) => pt == PopupType.BLUETOOTH,
                    ),
                }),
                popupAudio({
                    visible: bind(popupType).as(
                        (pt) => pt == PopupType.AUDIO,
                    ),
                }),
                popupWifi({
                    visible: bind(popupType).as(
                        (pt) => pt == PopupType.WIFI,
                    ),
                }),
            ),
        ),
        new Window({
            exclusivity: Astal.Exclusivity.IGNORE,
            layer: Astal.Layer.TOP,
            className: "declickArea",
            visible: bind(popupType).as((pt) => pt != PopupType.NONE),
            gdkmonitor: gdkmonitor,
            anchor:
                Astal.WindowAnchor.TOP |
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.BOTTOM |
                Astal.WindowAnchor.LEFT,
            child: new Button({
                onClicked: () => popupType.set(PopupType.NONE),
            }),
        }),
    ];
}
