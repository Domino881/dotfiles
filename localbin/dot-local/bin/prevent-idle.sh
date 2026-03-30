#!/usr/bin/sh
systemd-inhibit --what=idle --why="Preventing screen timeout for 1h" sleep 1h
