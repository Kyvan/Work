# Libraries needed
import subprocess
import sys
import getpass


# Mount setup
def setting_mount_points():
    username = input("Which username are you making the RSA key for? ")

    # Variables
    upload_dir = '/home/' + username + '/upload'

    # Get the password
    password = getpass.getpass()

    # Make upload and change ownership
    subprocess.Popen(['mkdir', '-p', upload_dir])
    subprocess.Popen(['chown', username + ':' + username, upload_dir])

    # Getting server IP
    server_ip = input('What iss the IP for the server? ')

    # Adds the line to /etc/fstab to automount the shared drive on startup
    subprocess.Popen(
        ['echo', '//' + server_ip + '/DataDump', upload_dir, 'cifs', 'user,rw,uid=' + '`' + 'grep', username,
         "/etc/passwd | awk -F : '{ print $3 }'`,username=" + username + ',password=' + password,
         '0 0 >> /etc/fstab'])
    subprocess.Popen(['mount', '-a'])


# SSH RSA key setup
def creating_rsa_keys():
    # Get the username
    username = input("Which username are you making the RSA key for? ")

    # Variables
    rsa_dir = '/home/' + username + '/.ssh/'

    # Create the user's SSH RSA key
    subprocess.Popen(['ssh-keygen', '-t', 'rsa', '-N', '', '-f', rsa_dir + username + '_rsa'])
    subprocess.Popen(['mv', rsa_dir + username + '_rsa.pub', rsa_dir + 'authorized_keys'])

    # Move the private key
    subprocess.Popen(['mv', rsa_dir + username + '_rsa', "/home/`who | awk '{print $1}'`/."])
    subprocess.Popen(['chmod', 'o+rwx', "/home/`who | awk '{print $1}'`/" + username + "_rsa"])

    # Checks to see if Mounting is needed
    mount_needed = input("Do you need to mount a drive for this user? (Yes/No) ")
    if mount_needed.lower() == "yes" or mount_needed.lower() == "y":
        setting_mount_points()
    else:
        print('RSA key has been generated and can be used now.')
        sys.exit(0)


# User creation funtion
def create_sftp_user():
    # Get the username
    username = input("What's the username? ")

    # Get the password
    password = getpass.getpass()

    # home_dir variable
    home_dir = '/home/' + username

    try:
        # Excute useradd command using subprocess
        subprocess.Popen(['useradd', '-p', password, '-G', 'wheel', '-md', home_dir, '-s', '/bin/bash', username])
    except:
        print(f"Failed to add user.")
        sys.exit(1)

    # Checks to see if RSA keys are needed
    rsa_key = input("Does this user need an RSA key? (Yes/No) ")
    if rsa_key.lower() == "yes" or rsa_key.lower() == "y":
        creating_rsa_keys()
    else:
        print('User has been created and is ready to be used.')
        sys.exit(0)


def delete_existing_user():
    username = input("What is the username to delte? ")
    subprocess.Popen(['userdel', '-r', username])
    print('User has been deleted.')
    sys.exit(0)


user_choice = True
while user_choice:
    print("""
    1. Create new SFTP User
    2. Delete exisitng user
    3. Create RSA key for user
    4. Setup SMB mount points
    5. Exit/Quit
    """)
    user_choice = input("What would you like to do? ")
    if user_choice == "1":
        create_sftp_user()
    elif user_choice == "2":
        delete_existing_user()
    elif user_choice == "3":
        creating_rsa_keys()
    elif user_choice == "4":
        setting_mount_points()
    elif user_choice == "5":
        print("\n Goodbye")
        sys.exit(0)
    elif user_choice != "":
        print("\n Not Valid Choice Try again")
