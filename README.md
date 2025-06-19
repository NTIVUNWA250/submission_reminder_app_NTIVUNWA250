Submission Reminder App

This is a Bash-based system to help students track their works that have been or not been submitted. This app helps teachers and students to set reminders, monitor submissions and run checks from the terminal.

The app:

    -Creates the environment folder containing needed resources
    -It tracks the submissions of the assignments for students
    -Notifies which students that haven't submitted the work
    -The App notifies the students that submitted
    -It lets you decide/configure which assignment to track
    -It runs a reminder script to show pending submissions

To get started:

Download the project or use git clone
    Set up your environment by running 'create_environment.sh': 
        a. You will be asked to enter your name 
        b. It will create a folder that contains your name in it (submission_reminder_your name) which contains all files and folders needed.
    Configure the assignment to track by running 'copilot_shell_script.sh': 
        a. You will be asked a folder to checkup and which assignment to track (Git, Shell Navigation, etc) 
        b. You will be asked how many days left till submission


Start of the Reminder App normally the app will start during setup but if not run it like this ./submission_reminder_/startup.sh: The app will: Read the entered assignment Search submissions.txt for students who haven't submitted Print reminders in the terminal

Rules:

    -Entered names (of a user) must contain only letters and spaces
    -Entered Assignment names must be letters/spaces (e.g., Shell Basics)
    -Days remaining must be numerical
    -Assignment name must be existing already inside submissions.txt


Made by Gilbert NTIVUNWA for bash learning purposes only.