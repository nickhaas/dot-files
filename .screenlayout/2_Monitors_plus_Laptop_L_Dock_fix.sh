#!/bin/bash
xrandr --newmode "1920x1200"
xrandr --addmode DP1-2 1920x1200
xrandr --addmode DP1-1 1920x1200
sleep 5
xrandr --output VIRTUAL1 --off 
xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off 
xrandr --output HDMI2 --off 
xrandr --output HDMI1 --off 
xrandr --output DP1-3 --off 
xrandr --output DP1-2 --mode 1920x1200 --pos 3840x0 --rotate normal 
xrandr --output DP1-1 --mode 1920x1200 --pos 1920x0 --rotate normal
nitrogen --restore
