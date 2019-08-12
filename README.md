This playbook is for setting up a local development environment primarily for the Apache, MySQL (MariaDB), and PHP stack. However, it additionally installs Node.js, MongoDB, and some mobile development tools.

### Setup and configuration

The variables and tasks run by this playbook will be determined by your OS family. On Mac OS, the OS family name is `Darwin` so the default variables loaded are in `vars/Darwin.yml`.

You can create a config.yml at the project root to override the default variables.

### Running this playbook

Use the following command to run this playbook, and enter your root password when prompted.

```
ansible-playbook -i inventory -K main.yml
```

### OS specific instructions

- [Mac OS](doc/macos/README.md)