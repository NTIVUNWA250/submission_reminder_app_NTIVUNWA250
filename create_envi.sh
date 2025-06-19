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