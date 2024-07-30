Step 1: Prepare the Input File
First, we need to prepare an input file that lists the usernames and groups.

Create a text file named users.txt in the same directory as the script.

Format the file with each line containing a username and group(s) separated by a semicolon (;). If a user belongs to multiple groups, separate the group names with commas (,).

Example users.txt

alice;developers,admins
bob;developers
carol;admins

Step 2: Create the Script File
Next, we need to create the script file.

Open your favorite text editor.
Copy the entire create_users.sh script into the editor.
Save the file with the name create_users.sh in the same directory as users.txt.
Step 3: Make the Script Executable
Before we can run the script, we need to make it executable.

Open a terminal.
Navigate to the directory where create_users.sh is saved.
Run the following command:


chmod +x create_users.sh

Step 4: Run the Script with Superuser Privileges
The script needs superuser (root) privileges to create users and groups, so we'll use sudo to run it.

In the terminal, ensure you're in the directory containing create_users.sh.
Run the script using sudo:

sudo ./create_users.sh

Step 5: Check Logs and Passwords
After running the script, it's important to check the logs and the generated passwords.

Log File: The script logs its actions to /var/log/user_management.log. Check this file for any warnings or errors:

code

sudo cat /var/log/user_management.log

Password File: The generated passwords are securely stored in /var/secure/user_passwords.txt. Check this file to retrieve the passwords:

sudo cat /var/secure/user_passwords.txt


Important Notes:
Permissions and Security:

Make sure the users.txt file is correctly formatted to avoid any errors during script execution.
The password file /var/secure/user_passwords.txt is created with secure permissions (readable only by root) to protect sensitive information.
Handling Errors:

The script includes error handling to log issues such as existing users or group creation failures.
Review the log file /var/log/user_management.log after running the script to identify and resolve any issues.
