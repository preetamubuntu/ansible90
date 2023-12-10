# Installing Ansible on RHEL 8
subscription-manager repos --list
subscription-manager repos --enable=ansible-2-for-rhel-8-x86_64-rpms
yum install ansible
ansible --version
rpm -qa | grep python