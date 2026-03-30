import { bind, Binding, Variable } from "astal";
import { Gtk } from "astal/gtk3";
import {
    Box,
    Label,
    Overlay,
    Revealer,
    Icon,
} from "astal/gtk3/widget";

export default function batteryPill({
    percentage,
    charging,
    pluggedIn,
    vertical,
    greenFill,
}: {
    percentage: number | Binding<number>;
    charging: Binding<Boolean> | null;
    pluggedIn: Binding<Boolean> | null;
    vertical: boolean;
    greenFill: boolean;
}): Gtk.Widget {
    const percentageVar =
        typeof percentage == "number"
            ? new Variable(percentage)
            : percentage;

    const batteryLabel = (transparent: boolean = false) =>
        new Box(
            {
                className: vertical
                    ? "BatteryPillLabel BatteryPillLabelVertical"
                    : "BatteryPillLabel",
                css: transparent ? "color: transparent;" : "",
            },
            new Revealer({
                reveal_child: pluggedIn?.as(Boolean),
                transition_type:
                    Gtk.RevealerTransitionType.SLIDE_LEFT,
                transitionDuration: 1000,
                child: new Icon({
                    icon: charging?.as(
                        c => c ? "camera-flash-symbolic" : "dot-symbolic",
                    ),
                }),
            }),
            new Label({
                halign: Gtk.Align.CENTER,
                valign: Gtk.Align.FILL,
                useMarkup: true,
                label: bind(percentageVar).as((p) =>
                    '<span line_height="0.5">'
                    + Math.round(p).toString()
                    + '</span>',
                ),
            }),
        );
    const cssSize = bind(percentageVar).as(
        (p) => `background-size: ${Math.round(p).toString()}%`,
    );
    return new Overlay(
        { className: "BatteryPill" },
        new Box(
            {
                className: "BatteryPillBg",
                css: vertical ? "border-radius: 6px;" : "",
            },
            new Box({
                child: batteryLabel(true),
            }),
        ),
        new Box({
            className: bind(percentageVar).as(
                (p) =>
                    (p < 20 ? "BatteryPillFillCritical " : "") +
                    (greenFill ? "BatteryPillFillGreen " : "") +
                    "BatteryPillFill",
            ),
            css: vertical
                ? "background-position: 0% 100%; border-radius: 6px;" + cssSize
                : cssSize,
        },
            batteryLabel(),
        ),
    );
}
