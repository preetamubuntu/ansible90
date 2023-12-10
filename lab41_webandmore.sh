#!bin/bash
# install http server
# copy /etc/hosts to /tmp
# create a user anna

ansible rocky -m user -a "name=anna"
ansible rocky -m yum -a "name=httpd state=present"
ansible rocky -m service -a "name=httpd state=started enabled=true"
ansible rocky -m copy -a "src=/etc/hosts dest=/tmp"