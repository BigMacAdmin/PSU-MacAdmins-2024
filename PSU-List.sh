#!/bin/zsh --no-rcs
set -x

# PSU-List.sh by: Trevor Sysock

dialog_command(){
    # $1 is the command you want to send to your running dialog
    echo "$@" >> /var/tmp/dialog.log
    sleep .1
}

# Open our dialog window with options from our JSON
/usr/local/bin/dialog \
    --jsonfile PSU-List.json &
sleep 1

# List of display names on our window
displayNames=(
    "Verifying Information"
    "Uploading Data"
    "Processing Response"
)

# Stop the progressbar bounce
dialog_command "progress: 1"

# Total progress bar progression
totalProgress=0

# The number of items in our list
numberOfItems="${#displayNames[@]}"

# The number of items in our list divided by 100 progress steps
progressIncrement=$(( 100 / numberOfItems ))

sleep 1
# Iterate through each name on the list
for displayName in ${displayNames[@]}; do
    # Start the status text
    dialog_command "listitem: title: ${displayName}, statustext : ..."

    # Make our progress bar go vroom
    progress=0
    until [ $progress -gt 100 ]; do
        dialog_command "listitem: title: ${displayName}, progress: $progress"
        progress=$(( progress + 6 ))
    done

    # Clear our status text
    dialog_command "listitem: title: ${displayName}, statustext : "

    # Add the green checkmark
    dialog_command "listitem: title: ${displayName}, status: success"
    count=$(( count + 1 ))
    totalProgress=$(( progressIncrement + totalProgress ))
    dialog_command "progress: ${totalProgress}"
done

# Finish the progress bar
dialog_command "progress: 100"

# Change the button text and enable it
dialog_command "button1text: Dismiss"
dialog_command "button1: enable"
