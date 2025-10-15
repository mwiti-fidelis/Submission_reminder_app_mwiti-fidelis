
#!/usr/bin/bash
#Create a script that runs the reminder app
if [  ! -f submissions_reminder_'fiii'/config/config.env  ]; then
    echo Error. The config.env does not exist and cannot start the reminder app
    exit 1
fi

./submissions_reminder_'fiii'/app/reminder.sh


