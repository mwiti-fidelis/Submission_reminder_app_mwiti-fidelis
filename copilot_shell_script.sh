#!/usr/bin/bash

#Prompts the user to enter the assignment name, then the new input will replace the current name in config/config.env on the ASSIGNMENT value (row 2)
#With the sed Or other suitable commands, the input of the assignment can replace the value in config/config.env
#When the replacement is complete, you can rerun startup.sh that will check the non-submission status of students for the new assignment that was saved in the config/config.env.

#check if the file config/config.env exists
if [  ! -f "config/config.env"  ];then 
	echo "Error!file does not exist"
	exit 1
fi

#ask for user input on the new assignment

read -p "Enter the name of the assignment: " assignment

if [[ -z "$new_assignment" ]]; then
    echo "Error: New assignment name cannot be empty"
    exit 1
fi

#replace the user input with the current name in config/config.env on row2
sed -i 's/^ASSIGNMENT=.*ASSIGNMENT=\"$new_assignment\"/' config/config.env

if ! grep -q "^ASSIGNMENT=\'$new_assignment\'$" config/config.env
    echo "Assignment not updated properly"
    exit 1
fi

echo "Asignment updated successfully to: $new_assignment"
#rerun the startup.sh to check the changes in assignment and the submission status

if [[ ! -f startup.sh ]]; then
    echo "Error: startup.sh file cannot be found and cannot rerun the app"
    exit 1
fi

./startup.sh
