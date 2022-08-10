#!/bin/bash

# The script for configuring a machine with Debian OS.
# The script creates a user whose name is passed by the first parameter 
# and grants him access via an ssh key, the path to which is passed in the second parameter

USERNAME=$1
USER_HOME="/home/$USERNAME"
SSH_PUB_KEY_PATH=$2

echo "System Upgrade"
apt-get update # > /dev/null 
apt-get upgrade -y # > /dev/null
apt-get install sudo -y # > /dev/null 

echo "Adding user"
useradd $USERNAME -m -s /bin/bash 
echo "$USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USERNAME\_perms
chmod 440 /etc/sudoers.d/$USERNAME\_perms

echo "SSH Daemon configuring"
sed -i '/^PermitRootLogin/c\PermitRootLogin no' /etc/ssh/sshd_config
sed -i '/^#PasswordAuthentication/a PasswordAuthentication no' /etc/ssh/sshd_config
echo "OK!"

echo "Create ssh auth password"
[ ! -d $USER_HOME/.ssh ] && mkdir $USER_HOME/.ssh

echo "Generate key"
ssh-keygen -i -f /dev/stdin <<< `cat $SSH_PUB_KEY_PATH` >> $USER_HOME/.ssh/authorized_keys
chmod 600 $USER_HOME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME $USER_HOME/.ssh

echo "Restart sshd"
systemctl restart sshd


echo "Done!"
echo "$USERNAME, created!"

