#!/usr/bin/env bash
set -e

echo "Resetting I2C controller and touchpad..."

# First unbind touchpad
echo "i2c-GXTP7863:00" > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind || true

# Reset I2C controller 
echo "AMDI0010:00" > /sys/bus/platform/drivers/i2c_designware/unbind
sleep 3
echo "AMDI0010:00" > /sys/bus/platform/drivers/i2c_designware/bind

# Wait for I2C to stabilize
sleep 2

# Disable power management
# echo "on" > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/AMDI0010:00/power/control

# Rebind touchpad
echo "i2c-GXTP7863:00" > /sys/bus/i2c/drivers/i2c_hid_acpi/bind

sudo modprobe -r i2c_hid_acpi && sudo modprobe i2c_hid_acpi

notify-send "Reset complete"
