#!/bin/bash

echo "🧠 Welcome to the Copilot Assignment Configurator!"

# Prompt the user for the assignment name
read -p "Enter the new assignment name: " new_assignment

# Path to the config file
config_path="/mnt/c/Users/pc/Documents/GitHub/submission_reminder_app_NTIVUNWA250/$p_dir/config/config.env"

# Check if the config file exists
if [ ! -f "$config_path" ]; then
  echo "❌ Error: config.env not found at $config_path"
  exit 1
fi

# Update the ASSIGNMENT line (expected on line 2)
# This assumes there's already a line like: ASSIGNMENT="..."
sed -i "2s|.*|ASSIGNMENT=\"$new_assignment\"|" "$config_path"

echo "✅ ASSIGNMENT updated to \"$new_assignment\" in $config_path"

# Rerun the startup script
if [ -x "./startup.sh" ]; then
  echo "🚀 Launching the Submission Reminder App..."
  ./startup.sh
else
  echo "⚠️ Could not run startup.sh — script not found or not executable."
fi
