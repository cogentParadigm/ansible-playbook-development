## Mac OS setup guide

To setup Mac OS, you'll need to do the following manually before you can run this ansible playbook.

1. Update Mac OS
1. Install Xcode
2. Install Command Line Tools for Xcode
3. Install MacPorts
4. Install ansible

### Update Mac OS

You should be running Mac OS 10.14 or later. If you are updating major versions, 10.13 to 10.14 for example, then you'll need to re-install MacPorts and your installed ports using the [Migration Guide(https://trac.macports.org/wiki/Migration).

### Installing Xcode

You can install Xcode through the App Store. You should be running version 10.2 or later.

### Installing Command Line Tools for Xcode

After each Xcode update, you'll want to install the command line tools and accept the license agreement by running the following commands:

```
xcode-select --install
sudo xcodebuild -license
```

### Installing MacPorts

Simply download the appropriate installer from [MacPorts](https://www.macports.org/install.php) and run it.

### Installing Ansible

To install ansible run:

```
sudo port install py-ansible
```
