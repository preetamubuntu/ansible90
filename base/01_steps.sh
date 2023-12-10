#!/bin/bash
ssh-keygen -t ed25519 -C "Preetam"
ssh-copy-id -i ~/.ssh/id_ed25519.pub 192.168.50.115
ssh-copy-id -i ~/.ssh/id_ed25519.pub 192.168.50.129
eval $(ssh-agent)
ssh-add 
create a alias entry in .bashr
alias ssha='eval $(ssh-agent) && ssh-add'
# to get shared folder, you have to install guest utils package
sudo apt install virtualbox-guest-utils -y
# add yourself to vboxsf
sudo adduser preetam vboxsf
alias sshap='eval $(ssh-agent) && ssh-add'