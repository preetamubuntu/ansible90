# Chapter 8_1 : REVIEW QUESTIONS

## Which module should you use to work with file system ACLs?

You can use either stat or file module?
WRONG


## Which modules can you use to replace strings in text files based on regex? (List two.)

lineinfile and blockinfile (WRONG) can use be usedd

## Which module should you use to retrieve file status?

stat module

## List three tasks that are commonly executed using the file module.

- create file
- create directory
- create link file

## Which module should you use to synchronize the contents of a file with the contents of a file on the control host?

fetch module? (WRONG)

## What is wrong with using the file module to manipulate SELinux file context?

changes made via file module can be overwritten by restorecon

## Which module can you use to change SELinux Booleans?

seboolean module

## A playbook runs successfully, but the handler in that playbook is not triggered. What is the most common explanation?

Handler is already triggered and handlers is triggered only once

## How do you include a comment line in a Jinja2 template?

using '#' (WRONG)

What is the if statement used for in Ansible templates?

****
