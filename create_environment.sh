#!/bin/bash

# Prompt the user to enter the name

echo "Welcome to the Submission Reminder App setup!"

# Loop until a valid name is entered
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

# Creating the folder

p_dir="submission_reminder_$name"

if [ -d "$p_dir" ]; then
	echo "Error!! Directory already exists."
    echo "Please run create_environment.sh again with a different name."
	echo "Aborting"
	echo "-------------------------"
	exit 1
else
	mkdir -p "$p_dir"
    echo "---------------------------------------"
    echo "Directory '$p_dir' created successfully."
	echo "Proceeding to finalising the environment" 
	echo "inside.................................."
fi

# Navigate into it
cd "$p_dir" || exit


# Creating subdirectories 
mkdir -p "$p_dir/app"
mkdir -p "$p_dir/modules"
mkdir -p "$p_dir/assets"
mkdir -p "$p_dir/config"

# Creating empty files in the sub-directories
[ ! -f "$p_dir/app/reminder.sh" ] && touch "$p_dir/app/reminder.sh"
[ ! -f "$p_dir/modules/functions.sh" ] && touch "$p_dir/modules/functions.sh"
[ ! -f "$p_dir/assets/submissions.txt" ] && touch "$p_dir/assets/submissions.txt"
[ ! -f "$p_dir/config/config.env" ] && touch "$p_dir/config/config.env"
[ ! -f "$p_dir/startup.sh" ] && touch "$p_dir/startup.sh"

# Adding content to the empty files in the sub-directories
echo "Adding content to the created files..."
# Appending the content needed in the created empty files
# Adding contents in reminder.sh

echo '
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
' >> $p_dir/app/reminder.sh

# Adding contents in functions.sh
echo '
#!/bin/bash

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
' >> $p_dir/modules/functions.sh

# Adding contents in submissions.txt
echo '
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
' >> $p_dir/assets/submissions.txt

# Adding contents in config.env
echo '
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
' >> $p_dir/config/config.env

# Adding contents in startup.sh

cat <<EOL >> "$p_dir/assets/submissions.txt"
Ntivunwa, Git, not submitted
Gilbert, Shell Navigation, submitted
Odon, Git, not submitted
Scovia, Shell Basics, submitted
Oblack, Shell Navigation, not submitted
EOL

# Create startup.sh with logic to run the app

cat << 'EOL' > "$p_dir/startup.sh"
#!/bin/bash
# Startup script for Submission Reminder App

cd "$(dirname "$0")"
bash ./app/reminder.sh
EOL

# Making them executable
find . -type f -name "*.sh" -exec chmod +x {} \;
#chmod +x "$p_dir/app/reminder.sh"
#chmod +x "$p_dir/modules/functions.sh"
#chmod +x "$p_dir/assets/submissions.txt"
#chmod +x "$p_dir/config/config.env"
#chmod +x "$p_dir/startup.sh"

# Tell the user that we're done

echo "The setup is completed✅✅✅."
echo "-----------------------------"
echo "You can check: $p_dir"
echo "-----------------------------"