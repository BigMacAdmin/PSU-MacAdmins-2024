#!/bin/zsh --no-rcs
#set -x
# ProgressExample2.sh by: Trevor Sysock

dialogCommandFile=$(mktemp /var/tmp/Example.XXXXX)

function dialog_command(){
    # $1 is the command we want to send
    # to our running dialog window
    echo "${1}" >> "$dialogCommandFile"
    sleep .1
}

/usr/local/bin/dialog \
    --title "Installing Mist" \
    --message "Please wait while we install your software..." \
    --icon "https://raw.githubusercontent.com/ninxsoft/Mist/main/README%20Resources/App%20Icon.png" \
    --button1disabled \
    --progress 4\
    --commandfile "$dialogCommandFile" \
    --moveable --ontop --mini &

sleep .5

dialog_command "progresstext: Downloading installer" 
dialog_command "progress: increment"
dialog_command "progresstext: Verifying package" 
dialog_command "progresstext: Installing" 
dialog_command "progresstext: Cleaning up" 
dialog_command "progresstext: Thank You!" 
dialog_command "quit:"