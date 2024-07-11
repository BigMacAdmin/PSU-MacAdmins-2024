#!/bin/zsh --no-rcs
# shellcheck shell=bash
/usr/local/bin/dialog \
    --message "You're in a desert walking along in the sand when all of a sudden you look down and you see a tortoise laying on it's back."\
    --checkbox "Do you help it?"\
    --checkboxstyle switch \
    --title "none" \
    --icon "./TyrellCorp.png" \
    --centericon --ontop --moveable \
    --height 350 --width 410 \
    #--builder