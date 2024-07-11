#!/bin/zsh --no-rcs
# shellcheck shell=bash
#et -x

# WhoAmI.sh by: Trevor Sysock

/usr/local/bin/dialog \
    --title none \
    --message "WhoAmI.md" \
    --icon "speakerPortrait.JPG" \
    --overlayicon "BigMacAdmin.png" \
    --moveable --ontop \
    --height 650 \
    --width 1200 \
    --infobox "WhoAmI.Info.MD" \
    --iconsize 300 \
    #--builder



