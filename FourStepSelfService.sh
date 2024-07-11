#!/bin/bash
# set -x

# FourStepSelfService.sh by: Trevor Sysock
# 2024-06-05

dialogCommandFile=$(mktemp /var/tmp/Example.XXXXX)

function dialog_command(){
    # $1 is the command we want to send to our running dialog window
    echo "${1}" >> "$dialogCommandFile"
    sleep .1
}

/usr/local/bin/dialog \
    --title "Installing Low Profile" \
    --message "Please wait while we install your software..." \
    --icon "/Applications/Low Profile.app" \
    --button1disabled \
    --progress \
    --commandfile "$dialogCommandFile" \
    --moveable --ontop --mini &

/usr/local/Installomator/Installomator.sh lowprofile DIALOG_CMD_FILE="$dialogCommandFile"

dialog_command "quit:"
