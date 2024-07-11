#!/bin/bash
#set -x

# Installomator-Dialog-List-Integration.sh by: Trevor Sysock
# 2024-07-02

# This script will:
#   - Take a CSV formatted array of items to install
#   - Create a swiftDialog list view with all items
#   - Run Installomator to install all items
#   - Create a macOS Notification Center Event upon completion

# This script:
#   - Assumes swiftDialog is installed
#   - Assumes Installomator is installed
#   - Is intended as a demonstration on how to use these tools
#       - Does not do error checking or any pre-flight verification
#       - For more a more robust solution, check out Baseline 
#       - https://github.com/SecondSonConsulting/Baseline
#   - Only contains 49 lines of code! (including 5 lines for the list of apps)

#####################
#   Configuration   #
#####################

# An array containing any options we want for our Dialog list view window
dialogOptions=(
    --title "PSU Fancy Example"
    --message "Thanks for sticking around this long..."
    --icon "./Icons/PSU.png"
    --height 420
    --ontop --moveable
)

# An array containing the apps we want to install
# Comma separated values: "label,DisplayName,Path to Icon"
# Each line should be encased in "quotes" so that it is one single array entry
apps=(
    "firefoxpkg,Firefox,./Icons/Firefox.png"
    "nudgesuite,Nudge,./Icons/Nudge.png"
    "lowprofile,Low Profile,./Icons/Low Profile.png"
    "mist,Mist,./Icons/Mist.png"
    "renew,Renew,./Icons/Renew.png"
)

# An array containing the options we want to use for Installomator
installomatorOptions=(
    NOTIFY=silent
    BLOCKING_PROCESS_ACTION=ignore
    DEBUG=1
)

# An array containing the options we want to use for our final notification
notificationOptions=(
    --title "That's all, folks..."
    --message "Thank you for coming!"
)

####################################
# DO NOT EDIT BELOW FOR NORMAL USE #
####################################
# Syntax:
#   Variables and arrays are "camel case": $thisIsAVariable
#   Functions are "snake case": this_is_a_function
#   Functions are declared with the declaration of "function this_is_a_function(){}"

#################
#   Variables   #
#################
# Paths to our tools
dialogPath="/usr/local/bin/dialog"
installomatorPath="/usr/local/Installomator/Installomator.sh"

# Create a tmp Dialog command file, and add it to our array of options
dialogCommandFile=$(mktemp /var/tmp/harrisonFord.XXXXXX)
dialogOptions+=(--commandfile "${dialogCommandFile}")
#################
#   Functions   #
#################
# execute a dialog command
function dialog_command(){
    /bin/echo "$@"  >> "$dialogCommandFile"
    sleep .1
}


##########################
#   Script Starts Here   #
##########################
# Create an empty array
dialogListView=()

# Create a Dialog list view
# Iterate through each entry in our $apps array to generate the list of 
#   apps we're installing
# If you want to get super-duper fancy, you could add "Description" as field 4
for app in "${apps[@]}"; do
    # Get the display name for this item
    displayName=$(echo "${app}" | cut -d ',' -f2)
    # Get the Icon path for this item
    displayIcon=$(echo "${app}" | cut -d ',' -f3)
    # Add to our final Dialog command
    dialogListView+=( --listitem "${displayName}",icon="${displayIcon}")
done

# Create our initial dialog utilizing the arrays of options we have created
# Send it to the background with &
"$dialogPath" "${dialogOptions[@]}" "${dialogListView[@]}" &
sleep 1

# For every item in our apps array, run the installomator label
# Include the swiftDialog options for integration
for app in "${apps[@]}"; do
    # Get our Label and DisplayName from our CSV
    label=$(echo "${app}" | cut -d ',' -f1)
    displayName=$(echo "${app}" | cut -d ',' -f2)

    # Make this list item pending and sleep 1 because it feels good
    dialog_command "listitem: ${displayName}: wait"
    sleep 1

    # Call installomator with all of our options
    "$installomatorPath" "${label}" \
        "${installomatorOptions[@]}" \
        DIALOG_CMD_FILE="${dialogCommandFile}" \
        DIALOG_LIST_ITEM_NAME=\'"${displayName}"\'
done

# Give a notification that we're done
"$dialogPath" --notification "${notificationOptions[@]}"

# That's it!!!
dialog_command "quit:"
rm "${dialogCommandFile}"
