#!/bin/zsh --no-rcs

# This is a lot to digest, maybe you should try using Json!
/usr/local/bin/dialog \
    --title "PSU Mac Admins 2024" \
    --message "Welcome to PSU Mac Admins 2024! Please give us a little information about yourself." \
    --icon "2024 MacAdmins Logo-Circle-Blue.png" \
    --ontop --moveable \
    --button1text 'Submit' \
    --button2text 'Maybe Later...' \
    --infobutton \
    --overlayicon "SF=pencil.and.list.clipboard" \
    --infobox \
"**July 8-12, 2024**\n\n\
Penn State University\n\n\
State College, PA, USA\n\n\
\n\n\
#### Thank you for your support!"\
    --height "460" \
    --textfield "Full Name",required \
    --textfield "Email",required \
    --textfield "Slack Handle" \
    --selecttitle "I am a:",radio,required \
    --selectvalues "Attendee,Speaker" \
    --checkbox "May we contact you to ask about your experience?",checked=true \
    --checkboxstyle switch \
    --vieworder "textfield,radiobutton,checkbox" \
