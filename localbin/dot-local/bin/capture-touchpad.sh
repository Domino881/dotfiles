#!/bin/bash
echo "=== Time: $(date) ==="
echo "--- I2C Bus State ---"
sudo i2cdetect -y -r 0 2>/dev/null || echo "Bus 0 failed"
sudo i2cdetect -y -r 1 2>/dev/null || echo "Bus 1 failed"
sudo i2cdetect -y -r 2 2>/dev/null || echo "Bus 2 failed"

echo "--- Touchpad Device ---"
ls -la /sys/bus/i2c/devices/i2c-GXTP7863:00/ 2>/dev/null || echo "Device missing"

echo "--- ACPI Power State ---"
cat /sys/bus/i2c/devices/i2c-GXTP7863:00/power/runtime_status 2>/dev/null

echo "--- Recent Errors ---"
sudo journalctl -n 50 | grep -E "i2c|GXTP|AMDI0010"
