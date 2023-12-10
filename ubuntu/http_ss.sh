#!/bin/bash

ansible rocky -m yum -a "name=httpd state=latest"
ansible rocky -m service -a "name=httpd state=started enabled=true"
