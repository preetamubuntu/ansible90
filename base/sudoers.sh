# Purpose
# To create pansible user on all vagrant machines
# and avoid using vagrant user.
# but you must create a key pair before you start.
# name of the vms are appie[01:03]

# vagrant ssh appie01
# vagrant ssh appie02
# vagrant ssh appie03

sudo su
export username='pansible'
export userpass='VMware1!2303'
useradd -m -c "Ansible User" -g adm -s /bin/bash $username
echo $username:$userpass | chpasswd
echo "$username ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$username
sed -i 's/PasswordAuthentication/#PasswordAuthentication/' /etc/ssh/sshd_config
systemctl restart sshd
exit
exit
# Below command should be run from the controller
ssh-copy-id -i ~/.ssh/pansible.pub pansible@192.168.56.50