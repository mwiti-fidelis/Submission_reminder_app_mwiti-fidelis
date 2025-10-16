#!/usr/bin/bash

#Creates and app reminder for students to ren=mind them on pending submissions

#ask for user input and create a directory submissions_reminder_{userinput}
read -p "Enter your name: " yourname
mkdir -p submission_reminder_$yourname

app_dir="submission_reminder_$yourname"

#create subdirectories
mkdir -p "$app_dir/app"
mkdir -p "$app_dir/modules"
mkdir -p "$app_dir/assets"
mkdir -p "$app_dir/config"

#create the files in their respective subdirectories with their contents
#create config.env and paste the content

cat > "$app_dir/config/config.env" <<'EOL'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

#create reminder.sh file and paste its content
cat > "$app_dir/app/reminder.sh" <<'EOL'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOL

#create and paste the contents of functions.sh
cat > "$app_dir/modules/functions.sh" <<'EOL'
#!/usr/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOL

#create and paste the contents of submissions.txt
cat > "$app_dir/assets/submissions.txt" <<'EOL'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Emmanuel, Git, submitted
Papa, Shell Basics, not submitted
Emna, Shell Nvigation, submitted
Alicia, Shell Basics, submitted
Sandrine, Git, not submitted 
EOL

#create startup script
cat > "$app_dir/startup.sh" <<'EOL'
#!/usr/bin/bash
#Create a script that runs the reminder app
if [  ! -f "config/config.env" ]; then
    echo "Error! The config.env does not exist and cannot start the reminder app"
    exit 1
fi

./app/reminder.sh
EOL

#give execution permissions to all .sh files

chmod +x "$app_dir/app/reminder.sh"
chmod +x "$app_dir/startup.sh"
chmod +x "$app_dir/modules/functions.sh"

echo "Enter cd $app_dir && ./startup.sh to run the app"
echo "successfully created the app environment"
echo "===========success========"
