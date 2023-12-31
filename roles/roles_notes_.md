# Notes on roles

There is default directory structure created for the role

1. **files** : to store all files required by the role. These files are static.
2. **templates** : all templates jinja are stored here. file type .j2
3. **vars** : All variables which not be overwritten are mentioned here. File type: yaml
4. **handlers** : All handlers are defined here.
5. **defaults** : variables which might be overwritten
6. **meta** : license information and dependencies (unclear to me)
7. **tasks** : role task definition
8. **test** : optional inventory and test.yaml file to test the role

All these directories are in plural.

with `ansible-galaxy init` command you can create the above default directory structure

```bash
ansible-galaxy init motd
# - Role motd was created successfully
tree motd
motd
├── defaults
│   └── main.yml
├── files
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── README.md
├── tasks
│   └── main.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

```

## Notes

Roles are created and supported by community. These roles can be found at ansible galaxy (<https://galaxy.ansible.com/ui/standalone/roles/>)
Redhat also provides RHEL System roles.

### Roles oder of execution?

Roles are executed before tasks. If you want tasks to take precedence, then use pre_tasks
you can create your own roles or can download from ansible galaxy. But there are community support
roles and also referred as systemroles. e.g. there is role rhel-system-roles.selinux

#### Oder of execution

- pre_tasks
- roles
- tasks
- handlers
- post_tasks


### Where are roles stored?

- ~/.ansible/roles only available to you
- ~/etc/ansible/roles available for everyone
- ~/.roles - in the current project directory
- /usr/share/ansible/roles installed from RPM sources and should not be used for storing custom roles

### Roles are a thing

You create role and this is just one of the task. But to use role, you need to create a playbook which will call this role.
And in this playbook you use or customize your requirements e.g. timeserver in case of chrony role

### Role dependencies

You configure role dependencies in meta/main.yaml file. Dependent role is called only once. e.g.

```yaml
dependencies:
    - role1: apache
      port: 8080
    - role2: mariadb
      when: environment == 'production'
```

### Ansible Galaxy

ansible_role in ansible.cfg defines where roles from ansible galaxy can be installed.
or you can choose each time you install the role using -p command as shown below

ansible-galaxy install geerlingguy.nginx -p /tmp













### Do you know ALREADY

1. In which role directory should you define role
variables that are not supposed to be overwritten
from a playbook?
a. vars
b. meta
c. files
d. defaults (MYCHOICE)

x 2. Roles can be found in many locations. Which of the
following locations should not be used for storing
custom-made roles?
a. ./roles (MYCHOICE) - Wrong
b. ~/.ansible/roles (MYCHOICE) - Wrong
c. /etc/ansible/roles
d. /usr/share/ansible/roles

3. Where do you find Ansible community-provided
roles?
a. In the Ansible registry
b. In the Ansible Git repository
c. In Ansible Galaxy (MYCHOICE)
d. On the Ansible website

4. You want to define a task that is executed after the
handlers in a playbook. How can you do that?
a. You can’t; handlers are always executed last.
b. You include these tasks in a role.
c. You make sure these tasks are defined after
the tasks that call the handlers.
d. You include them in a post_tasks section. (MYCHOICE)

5. Which file is used to define role dependencies?
a. README.md in the role directory
b. meta/main.yml in the role (MYCHOICE)
c. meta/main.yml in the project directory
d. the Ansible playbook

6. Which of the following commands allows you to set
up a directory structure for a custom role easily?
a. mkdir
b. ansible init
c. ansible-galaxy init (MYCHOICE)
d. ansible-galaxy setup

7. When working with Ansible Galaxy, you can specify
a requirements file. Which of the following specifies
the correct way to indicate the requirements file
that should be used?
a. Include requirements_file: filename in
the playbook that calls the roles.
b. Use ansible-galaxy install -r filename. (MYCHOICE)
c. Include a dependencies section in the
playbook, and in this section specify the
name of the requirements file.
d. Use the ansible galaxy -r filename
command.

x 8. Which command-line switch must be used with the
ansible-galaxy search command to find roles
that work on RHEL and CentOS?
a. --platforms EL
b. --platforms RHEL-family
c. --platforms RHEL (MYCHOICE) Wrong
d. --platforms CentOS

9. Which variable is used in the RHEL Timesync
System Role to identify that fast synchronization
should be used?
a. iburst (MYCHOICE)
b. fast_sync
c. hostname
d. timesync_ntp_servers

x 10. Which variables should be used in the RHEL
SELinux System Role to manage file context?
(Choose two.)
a. selinux_context
b. selinux_fcontext
c. selinux_dirs (MYCHOICE) Wrong
d. selinux_restore_dirs
