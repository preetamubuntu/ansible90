# Purpose
# To create pansible user on all vagrant machines
# and avoid using vagrant user.
# but you must create a key pair before you start.
# name of the vms are appie[01:03]

# vagrant ssh appie01
# vagrant ssh appie02
# vagrant ssh appie03

# step:01
    # vagrant ssh hostname
# step:02  change to super user using 
    # sudo su
# run the following commands
# Step:03
export username='sugrible1'
export userpass='lcG]cVVu9!a0NKPp1V'
useradd -m -c "Ansible User" -g adm -s /bin/bash $username
echo $username:$userpass | chpasswd
echo "$username ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$username
# this is required only for Ubuntu vagrant images ---- > sed -i 's/PasswordAuthentication/#PasswordAuthentication/' /etc/ssh/sshd_config && grep ^#PasswordAuthentication /etc/ssh/sshd_config
systemctl restart sshd
history -c && history -w && exit
exit
# run this command from Ubuntu desktop/controller host
# step:04
export ANSIBLEUSERNAME='sugrible1'
export HOSTIP=192.168.56.51
ssh-copy-id -i ~/.ssh/sugrible.pub $ANSIBLEUSERNAME@$HOSTIP

# [ Optional ] Below command should be run from the controller only if you are recreating environment
ssh-keygen -f ~/.ssh/known_hosts -R $HOSTIP

# step:05: you edit the /etc/hosts as below
    # 192.168.56.60 rockys01
    # 192.168.56.61 rockys02

# step:06 update the inventory file i.e one located in inventory/vagrant.ini
