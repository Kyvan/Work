# Libraries needed
import subprocess
import sys
import getpass

# Mount setup
def settingMountPoints():

    username = input("Which username are you making the RSA key for? ")

    # Variables
    uploadDir = '/app/'+username+'upload'

    # Get the password
    password = getpass.getpass()
    
    # Make upload and change ownership
    subprocess.run(['mkdir', '-p', uploadDir])
    subprocess.run(['chwon', username+':'+username, uploadDir+'upload'])

    # Getting server IP
    serverIP = input('What iss the IP for the server? ')

    # Adds the line to /etc/fstab to automount the shared drive on startup
    subprocess.run(['echo', '//'+serverIP+'/DataDump', uploadDir, 'cifs', 'user,rw,uid='+'`'+'grep', username,\
        "/etc/passwd | awk -F : '{ print $3 }'`,username="+username+',password='+password, '0 0 >> /etc/fstab'])
    subprocess.run(['mount', '-a'])



# SSH RSA key setup
def creatingRSAKeys():

    # Get the username
    username = input("Which username are you making the RSA key for? ")

    # Variables
    rsaDir = '/app/'+username+'/.ssh/'

    # Create the user's SSH RSA key
    subprocess.run(['ssh-keygen', '-t', 'rsa', '-N', '', '-f', rsaDir+username+'_rsa'])
    subprocess.run(['mv', rsaDir+username+'_rsa.pub', rsaDir+'authorized_keys'])

    # Move the private key
    # subprocess.run(['mv', rsaDir+username+'_rsa', "/home/`who | awk '{print $1}'`/."])
    # chmod o+rwx /home/`who | awk '{print $1}'`/"$userName"_rsa

    # Checks to see if RSA keys are needed
    mountNeeded = input("Do you need to mount a drive for this user? (Yes/No) ")
    if mountNeeded.lower() == "yes" or mountNeeded.lower() == "y":
    	settingMountPoints()
    else:
        print ('RSA key has been generated and can be used now.')
        sys.exit(0)

# User creation funtion
def createSFTPUser():
        
    # Get the username
    username = input("What's the username? ")

    # Get the password
    password = getpass.getpass()

    # homeDir variable
    homeDir = '/app/'+username

    # Chaning homeDir owner and permissions
    subprocess.run(['chwon', 'root'+':'+'root', homeDir])
    subprocess.run(['chmod', '0755', homeDir])

    try:
        # Excute useradd command using subprocess
        subprocess.run(['useradd', '-p', password, '-G', 'sftpUsers', '-md', homeDir, '-s', '/bin/bash', username])

    except:
        print ("ERROR: Failed to add user")
        print ("HINT: Make sure user doesn't exist already")
        sys.exit(1)
    
    # Checks to see if RSA keys are needed
    rsaKey = input("Does this user need an RSA key? (Yes/No) ")
    if rsaKey.lower() == "yes" or rsaKey.lower() == "y":
    	creatingRSAKeys()
    else:
        print ('User has been created and is ready to be used.')
        sys.exit(0)

userChoice=True
while userChoice:
    print ("""
    1.Create new SFTP User
    2.Create RSA key for user
    3.Setup SMB mount points
    4.Exit/Quit
    """)
    userChoice = input("What would you like to do? ") 
    if userChoice == "1": 
        createSFTPUser()
    elif userChoice == "2":
        creatingRSAKeys() 
    elif userChoice == "3":
        settingMountPoints() 
    elif userChoice == "4":
        print("\n Goodbye")
        sys.exit(0)
    elif userChoice != "":
        print("\n Not Valid Choice Try again") 