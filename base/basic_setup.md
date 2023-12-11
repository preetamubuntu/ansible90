# Basic setup for Ansible

- create a ssh key pair for login with paraphrase
- create a another ssh key pair for ansible usage without paraphrase
- use ssh agent to cache the key
``` bash
eval $(ssh-agent) && ssh-add
```
- make a alias for it.
- use export PROMPT_DIRTRIM=1


references
https://www.baeldung.com/linux/shorten-directory-path-command-line