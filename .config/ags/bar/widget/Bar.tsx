import { Variable, GLib, bind, exec, Binding, timeout } from "astal";
import { Astal, Gtk, Gdk, Widget } from "astal/gtk3";
import Hyprland from "gi://AstalHyprland";
import Mpris from "gi://AstalMpris";
import Battery from "gi://AstalBattery";
import Wp from "gi://AstalWp";
import Network from "gi://AstalNetwork";
import Tray from "gi://AstalTray";
import Bluetooth from "gi://AstalBluetooth";
import {
    Box,
    CenterBox,
    Label,
    Overlay,
    Revealer,
    EventBox,
    Button,
    Icon,
} from "astal/gtk3/widget";
import batteryPill from "./batteryPill";
import mainPopup, { PopupType } from "./popups";
import GDesktopEnums from "gi://GDesktopEnums?version=3.0";
import { subprocess } from "astal";

const openPopup = new Variable(PopupType.NONE);

function WorkspacesNiri({ monitor }: { monitor: Gdk.Monitor }) {
    const workspaces = Variable<number[]>([]);
    const focused = Variable<number>(-1);

    function updateWs() {
        let output = exec("niri msg workspaces");
        focused.set(parseInt(output.split("\n").filter(line => line.includes("*"))[0]
            .substring(2)));
        workspaces.set(
            output.split("\n").slice(1,)
                .map(line => parseInt(line.replace(" * ", ""))))

    }

    const ws = subprocess("niri msg event-stream", () => updateWs())

    return new Box({
        className: "Workspaces",
        hexpand: true,
        halign: Gtk.Align.START,
        children: bind(workspaces).as((wss) =>
            wss
                .sort((a, b) => a - b)
                .slice(0, -1)
                .map(
                    (ws) =>
                        new Button({
                            className: bind(
                                focused
                            ).as((fw) =>
                                ws === fw ? "focused" : "unfocused",
                            ),
                            onClicked: () => exec("niri msg action focus-workspace " + ws.toString()),
                            child: new Label({
                                label: ws.toString(),
                            }),
                        }),
                ),
        ),
    });
}

function Workspaces({ monitor }: { monitor: Gdk.Monitor }) {
    const hypr = Hyprland.get_default();

    return new Box({
        className: "Workspaces",
        hexpand: true,
        halign: Gtk.Align.START,
        children: bind(hypr, "workspaces").as((wss) =>
            wss
                .filter((ws) => !(ws.id >= -99 && ws.id <= -2))
                .filter((ws) =>
                    ws.monitor && monitor
                        ? ws.monitor.model == monitor.model
                        : true,
                )
                .sort((a, b) => a.id - b.id)
                .map(
                    (ws) =>
                        new Button({
                            className: bind(
                                hypr,
                                "focusedWorkspace",
                            ).as((fw) =>
                                ws === fw ? "focused" : "unfocused",
                            ),
                            onClicked: () => ws.focus(),
                            child: new Label({
                                label: ws.id.toString(),
                            }),
                        }),
                ),
        ),
    });
}

function SysTray() {
    const tray = Tray.get_default();

    const trayWidget = Variable.derive(
        [bind(tray, "items")],
        (items) => {
            const itemsFiltered = items.filter(
                (item) =>
                    item.id != "nm-applet" && item.id != "systray", // matebook-applet
            );
            if (itemsFiltered.length == 0) return [new Box()];
            else {
                const widgetArray = itemsFiltered.map(
                    (item) =>
                        new Widget.MenuButton({
                            tooltipMarkup: bind(
                                item,
                                "tooltipMarkup",
                            ),
                            usePopover: false,
                            actionGroup: bind(item, "actionGroup").as(
                                (ag) => ["dbusmenu", ag],
                            ),
                            menuModel: bind(item, "menuModel"),
                            child: new Widget.Icon({
                                gicon: bind(item, "gicon"),
                            }),
                        }),
                );
                const mainBox = new Box({
                    children: widgetArray,
                });
                mainBox.add(
                    new Label({
                        label: "|",
                        css: "opacity: 0.1; margin: 0px 5px 0px 5px;",
                    }),
                );

                return [mainBox];
            }
        },
    );

    return new Box({
        className: "SysTray",
        children: trayWidget(),
    });
}

function Time() {
    const hovered = Variable(false);

    const time = Variable<string>("").poll(
        25000,
        () => GLib.DateTime.new_now_local().format("%H:%M")!,
    );

    const date = Variable<string>("").poll(
        1000,
        () =>
            GLib.DateTime.new_now_local().format(":%S%t%A, %-e %B")!,
    );

    return new Box(
        {},
        new Overlay(
            { valign: Gtk.Align.FILL },
            new Box(
                {
                    className: "Time",
                },
                new Label({ label: time() }),
                new Revealer({
                    reveal_child: bind(hovered).as(Boolean),
                    transitionType:
                        Gtk.RevealerTransitionType.SLIDE_LEFT,
                    transitionDuration: 150,
                    child: new Label({ label: date() }),
                }),
            ),
            new EventBox({
                onHover: () => {
                    hovered.set(true);
                },
                onHoverLost: () => hovered.set(false),
            }),
        ),
    );
}

function Wifi() {
    const network = Network.get_default();
    const tray = Tray.get_default();

    const getWifiTooltip = () => {
        if (!network.get_wifi()?.enabled) {
            return "Wifi disabled";
        }
        switch (network.get_wifi()?.state) {
            case Network.DeviceState.DISCONNECTED:
                return "disconnected";
            case Network.DeviceState.FAILED:
                return "failed";
            case Network.DeviceState.UNAVAILABLE:
                return "unavailable";
            case Network.DeviceState.UNKNOWN:
                return "unknown";
            case Network.DeviceState.UNMANAGED:
                return "unmanaged";
            default:
                return network.wifi.get_ssid();
        }
    }
    const wifiTooltip = new Variable(getWifiTooltip());

    const getWifiIcon = () => {
        if (network.get_wifi()?.enabled) {
            return network.wifi.get_icon_name()
        }
        else {
            return "network-wireless-disabled-symbolic"
        }
    }
    const wifiIcon = new Variable(getWifiIcon());

    const wifiFromTray = Variable.derive(
        [bind(tray, "items")],
        (items) => {
            const matebookApplet = items.find(
                (i) => i.id == "nm-applet",
            );
            if (!matebookApplet) return new Box();

            return new Widget.MenuButton({
                label: "",
                usePopover: false,
                actionGroup: bind(matebookApplet, "actionGroup").as(
                    (ag) => ["dbusmenu", ag],
                ),
                menuModel: bind(matebookApplet, "menuModel"),
            });
        },
    );

    return bind(network, "wifi") && new Box({
        setup: (self) =>
            self.hook(network.wifi, "notify::state", () => {
                wifiIcon.set(getWifiIcon());
                timeout(800, () => {
                    // These didn't update with bind(wifi)
                    wifiIcon.set(getWifiIcon());
                    wifiTooltip.set(getWifiTooltip());
                });
            }),
        className: "component Wifi",
        tooltipText: bind(wifiTooltip),
        child: new Overlay(
            {},
            new Button({
                className: bind(network.wifi, "state").as((s) =>
                    s == Network.DeviceState.DISCONNECTED
                        || s == Network.DeviceState.FAILED
                        || s == Network.DeviceState.UNAVAILABLE
                        || s == Network.DeviceState.UNKNOWN
                        || s == Network.DeviceState.UNMANAGED
                        ? "BluetoothInactive"
                        : "",
                ),
                child: new Widget.Icon({
                    icon: bind(wifiIcon),
                }),
            }),
            wifiFromTray(),
        ),
    });
}

function BluetoothIndicator() {
    const bluetooth = Bluetooth.get_default();
    const hovered = Variable(false);

    const connectedDevices = Variable.derive(
        [bind(bluetooth, "is_connected"), bind(bluetooth, "devices")],
        (connected, devices) => {
            if (connected) {
                return devices.filter((d) => d.connected);
            } else return [];
        },
    );

    const btTooltop = Variable.derive(
        [bind(bluetooth, "isPowered"), bind(bluetooth, "isConnected"), bind(connectedDevices)],
        (powered, connected, devices) => {
            if (!powered) return "Bluetooth disabled";
            if (!connected) return "disconnected";
            return "Connected to:".concat(devices.join("\n"));
        }

    )
    const revealer = new Revealer({
        revealChild: bind(
            Variable.derive(
                [bind(hovered), bind(connectedDevices)],
                (h, cd) => h && cd.length > 0,
            ),
        ).as(Boolean),
        transitionType: Gtk.RevealerTransitionType.SLIDE_LEFT,
        child: new Box({
            className: "BluetoothReveal",
            children: bind(connectedDevices).as((devices) =>
                devices.map(
                    (d) =>
                        new Box({
                            tooltipText: d.name,
                            children: bind(
                                Variable("").poll(
                                    2000,
                                    "bluetoothctl info " + d.address,
                                ),
                            ).as((pString) => {
                                const p = pString
                                    .split("\n")
                                    .filter((line) =>
                                        line.includes(
                                            "Battery Percentage",
                                        ),
                                    )
                                    .map((line) =>
                                        line
                                            .split("(")[1]
                                            .substring(
                                                0,
                                                line.split("(")[1]
                                                    .length - 1,
                                            ),
                                    )[0];
                                return [
                                    new Widget.Icon({
                                        icon: d.icon,
                                    }),
                                    batteryPill({
                                        percentage: isNaN(parseInt(p))
                                            ? -1
                                            : parseInt(p),
                                        state: null,
                                        greenFill: true,
                                        vertical: true,
                                    }),
                                ];
                            }),
                        }),
                ),
            ),
        }),
    });

    const btEvBox = new EventBox({
        onHover: () => hovered.set(true),
        onHoverLost: () => hovered.set(false),
        child: new Box(
            {},
            revealer,
            new Button({
                onClicked: () => exec("scripts/toggle_blueberry"),
                className: bind(bluetooth, "is_powered").as((p) =>
                    p ? "Bluetooth" : "BluetoothInactive",
                ),
                tooltipText: bind(btTooltop),
                child: new Widget.Icon({
                    icon: bind(bluetooth, "is_connected").as((c) =>
                        c
                            ? "bluetooth-connected-symbolic"
                            : "bluetooth-symbolic",
                    ),
                }),
            }),
        ),
    });

    return new Box({
        className: "component Bluetooth",
        halign: Gtk.Align.CENTER,
        child: btEvBox,
    });
}

function AudioSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!;
    const hovered = Variable(false);

    const audioIcon = Variable.derive(
        [
            bind(hovered),
            bind(speaker, "icon"),
            bind(speaker, "volumeIcon"),
        ],
        (hovered, icon, volIcon) => {
            if (!hovered || icon == "audio-card-analog-pci")
                return volIcon;
            return icon;
        },
    );

    return new Box({
        className: "component AudioSlider",
        child: new EventBox({
            onHover: () => hovered.set(true),
            onHoverLost: () => hovered.set(false),
            setup: (self) => {
                if (speaker) {
                    self.hook(speaker, "notify::id", () => {
                        hovered.set(true);
                        timeout(1000, () => hovered.set(false));
                    });
                }
            },
            child: new Button({
                onClick: (_, event) =>
                    event.button == Astal.MouseButton.MIDDLE
                        ? speaker.set_mute(!speaker.get_mute())
                        : exec("scripts/toggle_pavucontrol"),
                child: new Icon({
                    tooltip_text: bind(speaker, "description").as(
                        desc =>
                            desc == "Family 17h/19h/1ah HD Audio Controller Analog Stereo" ?
                                "Laptop speakers" : desc
                    ),
                    icon: audioIcon(),
                }),
            }),
        }),
    });
}

function BatteryLevel2() {
    const bat = Battery.get_default();
    const tray = Tray.get_default();

    const timeRemaining = Variable.derive(
        [
            bind(bat, "time_to_empty"),
            bind(bat, "time_to_full"),
            bind(bat, "charging"),
            bind(bat, "isPresent"),
            bind(bat, "state"),
        ],
        (timeToEmpty, timeToFull, charging, isPresent, state) => {
            if (!isPresent) return "No battery";
            let time = charging ? timeToFull : timeToEmpty;

            const hours = Math.floor(time / 3600);
            const minutes = Math.floor((time % 3600) / 60);

            const timeStr =
                hours > 0
                    ? `${hours}h ${minutes.toString().padStart(2, "0")}m`
                    : `${minutes}m`;

            return charging
                ? state == Battery.State.CHARGING
                    ? `${timeStr} until full`
                    : "Charging stopped"
                : `${timeStr} remaining`;
        },
    );

    const batFromTray = Variable.derive(
        [bind(tray, "items")],
        (items) => {
            const matebookApplet = items.find(
                (i) => i.id == "systray",
            );
            if (!matebookApplet) return new Box();

            return new Widget.MenuButton({
                label: "",
                usePopover: false,
                halign: Gtk.Align.CENTER,
                actionGroup: bind(matebookApplet, "actionGroup").as(
                    (ag) => ["dbusmenu", ag],
                ),
                menuModel: bind(matebookApplet, "menuModel"),
            });
        },
    );

    return new Box({
        className: "component BatteryLevel2",
        visible: bind(bat, "isPresent"),
        tooltip_text: timeRemaining(),
        child: new Overlay(
            {},
            batteryPill({
                percentage: bind(bat, "percentage").as(
                    (p) => 100 * p,
                ),
                state: bind(bat, "state"),
                vertical: false,
                greenFill: false,
            }),
            batFromTray(),
        ),
    });
}

function BatteryLevel() {
    const bat = Battery.get_default();

    return (
        <box
            className="component Battery"
            visible={bind(bat, "isPresent")}
        >
            <icon icon={bind(bat, "batteryIconName")} />
            <label
                marginStart={2}
                label={bind(bat, "percentage").as(
                    (p) => `${Math.floor(p * 100)}%`,
                )}
            />
        </box>
    );
}

function MediaPlayer({ player }: { player: Mpris.Player }) {
    const hovered = Variable(false);

    const playIcon = bind(player, "playbackStatus").as((s) =>
        s == Mpris.PlaybackStatus.PLAYING
            ? "media-playback-pause-symbolic"
            : "media-playback-start-symbolic",
    );
    function lengthStr(length: number) {
        const min = Math.floor(length / 60);
        const sec = Math.floor(length % 60);
        const sec0 = sec < 10 ? "0" : "";
        return `${min}:${sec0}${sec}`;
    }
    function titleStr(artist: string, title: string) {
        const maxLength = 30;
        if (!title) {
            return "-";
        }
        let result = title + " - " + artist;
        if (result.length > maxLength) {
            result = result.slice(0, maxLength - 1) + "…";
        }
        return result;
    }

    return new Box({
        className: "Media",
        child: new EventBox({
            onHover: () => hovered.set(true),
            onHoverLost: () => hovered.set(false),
            child: new Box(
                {
                    spacing: 5,
                },
                new Button({
                    onClick: () =>
                        player.bus_name.includes("strawberry")
                            ? exec(
                                "hyprctl dispatch focuswindow 'class:org.strawberrymusicplayer.strawberry'",
                            )
                            : player.bus_name.includes("firefox")
                                ? exec(
                                    "hyprctl dispatch focuswindow 'class:firefox'",
                                )
                                : "",
                    child: new Icon({
                        icon: "audio-x-generic-symbolic",
                    }),
                }),
                new Revealer({
                    reveal_child: bind(hovered).as(Boolean),
                    transitionType:
                        Gtk.RevealerTransitionType.SLIDE_RIGHT,
                    child: new Box(
                        {
                            className: "MediaTime",
                        },
                        new Label({
                            label: bind(player, "position").as((l) =>
                                l > 0 ? lengthStr(l) + "/" : "0:00/",
                            ),
                        }),
                        new Label({
                            label: bind(player, "length").as((l) =>
                                l > 0 ? lengthStr(l) : "0:00",
                            ),
                        }),
                        new Box(
                            {
                                className: "MediaButtons",
                            },
                            new Button({
                                onClicked: () => player.previous(),
                                opacity: bind(
                                    player,
                                    "canGoPrevious",
                                ).as((v) => (v ? 1.0 : 0.2)),
                                child: new Icon({
                                    icon: "media-skip-backward-symbolic",
                                }),
                            }),
                            new Button({
                                onClicked: () => player.play_pause(),
                                opacity: bind(player, "canPlay").as(
                                    (v) => (v ? 1.0 : 0.2),
                                ),
                                child: new Icon({
                                    icon: playIcon,
                                    marginStart: 2,
                                }),
                            }),
                            new Button({
                                onClicked: () => player.next(),
                                opacity: bind(player, "canGoNext").as(
                                    (v) => (v ? 1.0 : 0.2),
                                ),
                                child: new Icon({
                                    icon: "media-skip-forward-symbolic",
                                }),
                            }),
                        ),
                    ),
                }),
                new Label({
                    label: bind(player, "metadata").as(() =>
                        titleStr(player.artist, player.title),
                    ),
                }),
            ),
        }),
    });
}

function Media() {
    const mpris = Mpris.get_default();

    return (
        <box>
            {bind(mpris, "players").as((arr) =>
                arr.map((player) => <MediaPlayer player={player} />),
            )}
        </box>
    );
}

function PowerButtons() {
    const hovered = Variable(false);
    // Animation is much smoother if the power button is left of revealer
    const leftButton = bind(hovered).as(h => {
        if (h) {
            return new Button({
                onClicked: () =>
                    exec("hyprctl dispatch exit"),
                tooltip_text: "Log out",
                child: new Icon({
                    icon: "system-log-out-symbolic",
                }),
            })
        } else {
            return new Button({
                className: "shutdown",
                tooltip_text: "Shutdown",
                onClick: () =>
                    hovered.get()
                        ? exec([
                            "bash",
                            "-c",
                            "kdialog --yesno 'Are you sure?'\
                            --yes-label 'Shutdown'\
                            --no-label 'Cancel' && systemctl poweroff",
                        ])
                        : hovered.set(true),
                child: new Icon({ icon: "system-shutdown-symbolic" }),
            })
        }
    })

    return new EventBox({
        className: "PowerButtons",
        onHover: () => hovered.set(true),
        onHoverLost: () => hovered.set(false),
        child: new Box(
            {},
            leftButton,
            new Revealer({
                reveal_child: bind(hovered).as(Boolean),
                transitionType: Gtk.RevealerTransitionType.SLIDE_RIGHT,
                transitionDuration: 900,
                child: new Box(
                    {},
                    new Button({
                        onClicked: () =>
                            exec("loginctl lock-session"),
                        tooltip_text: "Lock",
                        child: new Icon({
                            icon: "padlock2-symbolic",
                        }),
                    }),
                    new Button({
                        css: "font-size: 90%;",
                        onClicked: () => exec("systemctl suspend"),
                        tooltip_text: "Suspend",
                        child: new Icon({
                            icon: "media-playback-pause-symbolic",
                        }),
                    }),
                    new Button({
                        className: "reboot",
                        onClicked: () => exec([
                            "bash",
                            "-c",
                            "kdialog --yesno 'Are you sure?'\
                            --yes-label 'Reboot'\
                            --no-label 'Cancel' && systemctl reboot",
                        ]),
                        tooltip_text: "Reboot",
                        child: new Icon({
                            icon: "system-reboot-symbolic",
                        }),
                    }),
                    new Button({
                        className: "shutdown",
                        tooltip_text: "Shutdown",
                        onClick: () =>
                            hovered.get()
                                ? exec([
                                    "bash",
                                    "-c",
                                    "kdialog --yesno 'Are you sure?'\
                            --yes-label 'Shutdown'\
                            --no-label 'Cancel' && systemctl poweroff",
                                ])
                                : hovered.set(true),
                        child: new Icon({ icon: "system-shutdown-symbolic" }),
                    })
                ),
            }),
        ),
    });
}

export default function Bar(monitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

    return [
        new Widget.Window({
            className: "BarReserve",
            namespace: "top-bar",
            // css: "border: 1px dashed red;",
            exclusivity: Astal.Exclusivity.EXCLUSIVE,
            layer: Astal.Layer.BACKGROUND,
            gdkmonitor: monitor,
            anchor: TOP | LEFT | RIGHT,
            child: new Box({}),
        }),
        new Widget.Window({
            className: "Bar",
            namespace: "top-bar",
            exclusivity: Astal.Exclusivity.IGNORE,
            layer: Astal.Layer.BACKGROUND,
            gdkmonitor: monitor,
            anchor: TOP | LEFT,
            child: new Box(
                { halign: Gtk.Align.START },
                Workspaces({ monitor: monitor }),
                // WorkspacesNiri({ monitor: monitor }),
                Media(),
            ),
        }),
        new Widget.Window({
            className: "Bar",
            // namespace: "top-bar",
            exclusivity: Astal.Exclusivity.IGNORE,
            layer: Astal.Layer.BACKGROUND,
            gdkmonitor: monitor,
            anchor: TOP,
            child: Time(),
        }),
        new Widget.Window({
            className: "Bar",
            // namespace: "top-bar",
            exclusivity: Astal.Exclusivity.IGNORE,
            layer: Astal.Layer.BACKGROUND,
            gdkmonitor: monitor,
            anchor: TOP | RIGHT,
            child: new Box(
                {},
                new Box(
                    {
                        className: "Right",
                        hexpand: true,
                        halign: Gtk.Align.END,
                    },
                    SysTray(),
                    Wifi(),
                    BluetoothIndicator(),
                    AudioSlider(),
                    BatteryLevel2(),
                ),
                PowerButtons(),
            ),
        }),
        // ...mainPopup({
        //     gdkmonitor: monitor,
        //     popupType: openPopup,
        // }),
    ];
}
