# How to prepare lab on ubuntu desktop

step:01
Install and configure Vagrant

step:02
install and configure virtualbox
In the virtualbox change the NAT network setting as per your requirements.
i have created 192.168.56.0/24 network

step:03

create a key pair to be used for ansible
create a password hash

```bash
export ansible_user='sugrible'
ssh-keygen -t ed25519 -C $ansible_user

# create a password hash
mkpasswd --method=sha512crypt

```

step:03
create a vagrant file. For single host based on Rocky9 here is an example
refer create_ansibleuser.yaml file

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "rockylinux/9"
  config.vm.hostname = "testrocky"
  config.vm.network "private_network", ip: "192.168.56.70"
  config.vm.box_check_update = true
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "create_ansibleuser.yaml"
end
end
```

In case you need multiple hosts, then below is the respective vagrant file

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "rockylinux/9"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.linked_clone = true
  end
  # app01
  config.vm.define "rockys01" do |app01|
    app01.vm.hostname = "rockys01"
    app01.vm.network :private_network, ip: "192.168.56.70", hostname: true
  end
  # app02
  config.vm.define "rockys02" do |app02|
    app02.vm.hostname = "rockys02"
    app02.vm.network :private_network, ip: "192.168.56.71", hostname: true
  end
  # app03
  config.vm.define "rockys03" do |app02|
    app02.vm.hostname = "rockys03"
    app02.vm.network :private_network, ip: "192.168.56.72", hostname: true
  end
  # app04
  config.vm.define "rockys04" do |app02|
    app02.vm.hostname = "rockys04"
    app02.vm.network :private_network, ip: "192.168.56.73", hostname: true
  end
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "create_ansibleuser.yaml"
  end
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
end

```
If you are going to reprovision this lab, ensure you remove the SSH key from the knownhosts file as beloe

```bash
ssh-keygen -f ~/.ssh/known_hosts -R "192.168.56.50"
```
