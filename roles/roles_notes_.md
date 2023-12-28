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

Roles are executed before tasks. If you want tasks to take precedence, then use pre_tasks
you can create your own roles or can download from ansible galaxy. But there are community support
roles and also referred as systemroles. e.g. there is role rhel-system-roles.selinux
