import { App, Astal, Gdk, Gtk } from "astal/gtk3";
import { timeout } from "astal/time";
import { bind } from "astal";
import Variable from "astal/variable";
import Brightness from "./brightness";
import Wp from "gi://AstalWp";

function OnScreenProgress({
    visible,
}: {
    visible: Variable<boolean>;
}) {
    const brightness = Brightness.get_default();
    const speaker = Wp.get_default()!.get_default_speaker();
    const microphone = Wp.get_default()!.get_default_microphone();

    const iconName = Variable("");
    const value = Variable(0);

    let count = 0;
    function show(v: number, icon: string) {
        visible.set(true);
        value.set(v);
        iconName.set(icon);
        count++;
        timeout(800, () => {
            count--;
            if (count === 0) visible.set(false);
        });
    }

    return (
        <revealer
            setup={(self) => {
                self.hook(brightness, "notify::screen", () =>
                    show(
                        brightness.screen,
                        "display-brightness-symbolic",
                    ),
                );

                if (speaker) {
                    self.hook(speaker, "notify::volume", () =>
                        show(
                            speaker.volume,
                            speaker.mute
                                ? "audio-volume-muted-symbolic"
                                : speaker.icon ==
                                    "audio-card-analog-pci"
                                  ? speaker.volumeIcon
                                  : speaker.icon.includes("bluetooth")
                                    ? "bluetooth-symbolic"
                                    : "audio-card-analog-usb",
                        ),
                    );
                    self.hook(speaker, "notify::mute", () =>
                        show(
                            speaker.volume,
                            speaker.mute
                                ? "audio-volume-muted-symbolic"
                                : speaker.icon ==
                                    "audio-card-analog-pci"
                                  ? speaker.volumeIcon
                                  : speaker.icon.includes("bluetooth")
                                    ? "bluetooth-symbolic"
                                    : "audio-card-analog-usb",
                        ),
                    );
                }
                if (microphone) {
                    self.hook(microphone, "notify::volume", () =>
                        show(
                            microphone.volume,
                            microphone.volumeIcon,
                        ),
                    );
                    self.hook(microphone, "notify::mute", () =>
                        show(
                            microphone.volume,
                            microphone.volumeIcon,
                        ),
                    );
                }
            }}
            revealChild={visible()}
            transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
        >
            <box className="OSD">
                <icon icon={iconName()} />
                <levelbar
                    valign={Gtk.Align.CENTER}
                    widthRequest={140}
                    value={value()}
                />
            </box>
        </revealer>
    );
}

export default function OSD(monitor: Gdk.Monitor) {
    const visible = Variable(false);

    return (
        <window
            gdkmonitor={monitor}
            className="OSD"
            namespace="osd"
            application={App}
            layer={Astal.Layer.OVERLAY}
            keymode={Astal.Keymode.NONE}
            anchor={Astal.WindowAnchor.BOTTOM}
            visible={false} // Start hidden
            setup={(self) => {
                timeout(1000, () =>
                    visible.subscribe((isVisible) => {
                        self.visible = isVisible;
                    }),
                );
            }}
        >
            <eventbox onClick={() => visible.set(false)}>
                <OnScreenProgress visible={visible} />
            </eventbox>
        </window>
    );
}
