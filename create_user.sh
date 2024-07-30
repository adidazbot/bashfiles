#!/bin/bash

# This helps  script creates users and groups from a specified file.
# This script also generate random passwords for the users and logs all actions.

# Input file containing usernames and groups
input_file="users.txt"

# Log file for user management actions
log_file="/var/log/user_management.log"

# Secure file for storing generated passwords
password_file="/var/secure/user_passwords.txt"

# Function to generate a random 12-character password
generate_password() {
    tr -dc A-Za-z0-9 </dev/urandom | head -c 12
}

# Ensure the input file exists
if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file $input_file not found." | tee -a "$log_file"
    exit 1
fi

# Ensure the secure directory and password file exist with appropriate permissions
mkdir -p /var/secure
touch "$password_file"
chmod 600 "$password_file"

# Process each line of the input file
while IFS=';' read -r username groups; do
    # Skip the line if username is empty
    if [[ -z "$username" ]]; then
        echo "Warning: Empty username encountered. Skipping line." | tee -a "$log_file"
        continue
    fi

    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "Warning: User $username already exists. Skipping." | tee -a "$log_file"
        continue
    fi

    # Create the user with a home directory and default shell/ Error handling for failure to send an empty argument
    useradd -m "$username" -s /bin/bash
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to create user $username." | tee -a "$log_file"
        continue
    fi
    echo "Created user $username." | tee -a "$log_file"

    # Generate a random password for the user/ Error Handling for entring an empty argument for password.
    password=$(generate_password)
    echo "$username:$password" | chpasswd
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to set password for user $username." | tee -a "$log_file"
        continue
    fi

    # Store the generated password securely
    echo "$username:$password" >> "$password_file"

    # Create and add the user to specified groups
    IFS=',' read -ra group_array <<< "$groups"
    for group in "${group_array[@]}"; do
        if ! getent group "$group" &>/dev/null; then
            groupadd "$group"
            if [[ $? -ne 0 ]]; then
                echo "Error: Failed to create group $group." | tee -a "$log_file"
                continue
            fi
            echo "Created group $group." | tee -a "$log_file"
        fi
        usermod -aG "$group" "$username"
        if [[ $? -ne 0 ]]; then
            echo "Error: Failed to add user $username to group $group." | tee -a "$log_file"
        else
            echo "Added user $username to group $group." | tee -a "$log_file"
        fi
    done

    # Set appropriate permissions for the home directory
    chmod 700 "/home/$username"
    chown "$username:$username" "/home/$username"
    echo "Set permissions for /home/$username." | tee -a "$log_file"

done < "$input_file"

echo "User creation process completed." | tee -a "$log_file"



#github.com/adidazbot
