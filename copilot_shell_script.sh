#!/bin/bash

# Asking user to enter his/her preffered name
while true; do
    read -p "Enter your name: " name

    if [[ -z "$name" ]]; then
        echo "Name cannot be empty. Please try again."
        continue  # Goes back to the top of the loop
    elif ! [[ "$name" =~ ^[a-zA-Z\s]+$ ]]; then
        echo "The inputed name must contain only letters and spaces😑."
        echo "Please try again."
        continue  # Goes back to the top of the loop     
    fi

    echo "Hello, $name!"
    break  # Exit the loop when name is valid
done


# Adding and declaring variables to the directory and the submissions file

p_dir="submission_reminder_$name"
submissions_file="/mnt/c/Users/pc/Documents/GitHub/submission_reminder_app_NTIVUNWA250/$p_dir/assets/submissions.txt"

# Checking if the directory exists
if [ ! -d "$p_dir" ]; then
	echo "Directory '$p_dir' not found!!"
	echo "Please run create_environment.sh."
	echo "Aborting..."
	exit 1
fi

# Entry for the assignment and the days remaining
read -p "Enter the name for the assignment: " Assignment
read -p "Enter the number of days remaining for submission: " Days

# Sanitazing the variables input
Assignment=$(echo "$Assignment" | sed "s/$(echo -e '\u00a0')/ /g" | tr -cd '[:alnum:] [:space:]' | xargs)

Days=$(echo "$Days" | xargs)

echo "DEBUG: [$Assignment]"

# Input validation

# Checking if the Assignment name ain't empty and that the Days are numbers
if [ -z "$Assignment" ] || ! [[ "$Days" =~ ^[0-9]+$ ]]; then
    echo "The Assignment name cannot be empty!."
    echo "and" 
    echo "The Days have to be numbers."
    echo "------------------------------"
    echo "Aborting..."
    exit 1
fi

# Checking if the Assignment name ain't numerical
if ! echo "$Assignment" | grep -qE '^[A-Za-z ]+$'; then
    echo "The Assignment name must contain." 
    echo "only letters and spaces."
    echo "Aborting..."
    exit 1
fi

# Checking if the assignment exists in submissions.txt

matched_assignment=$(grep -i ", *$Assignment," "$submissions_file" | awk -F',' '{print $2}' | head -n1 | xargs)

if [ -z "$matched_assignment" ]; then
    echo "Assignment '$Assignment' isn't found in submissions.txt"
    echo "Try again."
    echo "Aborting..."
    exit 1
fi

# Update config.env

echo "Updating config.env in $p_dir/config/"
echo "ASSIGNMENT=\"$matched_assignment\"" > "/mnt/c/Users/pc/Documents/GitHub/submission_reminder_app_NTIVUNWA250/$p_dir/$p_dir/config/config.env"
echo "DAYS_REMAINING=$Days" >> "/mnt/c/Users/pc/Documents/GitHub/submission_reminder_app_NTIVUNWA250/$p_dir/$p_dir/config/config.env"

echo "Configuration updated:"
cat /mnt/c/Users/pc/Documents/GitHub/submission_reminder_app_NTIVUNWA250/$p_dir$p_dir/config/config.env

# Ask if they want to start the app
read -p "Would you like to run the reminder app now? (y/n): " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "...Starting the app..."
    bash "$p_dir/startup.sh"
    echo "The app has started and running"
    echo "_ _ _ _ _ _ _ _"
else
    echo "Reminder app not started!!."
    echo "You can run it later using: bash $p_dir/startup.sh"
fi