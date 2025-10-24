import { bind, Binding, Variable } from "astal";
import { Gtk } from "astal/gtk3";
import Battery from "gi://AstalBattery";
import {
    Box,
    Label,
    Overlay,
    Revealer,
    Icon,
} from "astal/gtk3/widget";

export default function batteryPill({
    percentage,
    state,
    vertical,
    greenFill,
}: {
    percentage: number | Binding<number>;
    state: Binding<Battery.State> | null;
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
                reveal_child: state?.as(
                    (state) =>
                        state == Battery.State.CHARGING ||
                        state == Battery.State.PENDING_CHARGE ||
                        state == Battery.State.PENDING_DISCHARGE,
                ),
                transition_type:
                    Gtk.RevealerTransitionType.SLIDE_LEFT,
                child: state
                    ? new Icon({
                          icon: bind(state).as((c) =>
                              c == Battery.State.CHARGING
                                  ? "camera-flash-symbolic"
                                  : "dot-symbolic",
                          ),
                      })
                    : new Box(),
            }),
            new Label({
                halign: Gtk.Align.CENTER,
                label: bind(percentageVar).as((p) =>
                    Math.round(p).toString(),
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
                ? "background-position: 0% 100%; border-radius: 6px;" +
                  cssSize
                : cssSize,
        }),
        batteryLabel(),
    );
}
