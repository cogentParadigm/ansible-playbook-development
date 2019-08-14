## Mac OS setup guide

To setup Mac OS, you'll need to do the following manually before you can run this ansible playbook.

1. Update Mac OS
1. Install Xcode
2. Install Command Line Tools for Xcode
3. Install MacPorts
4. Install ansible

### Update Mac OS

You should be running Mac OS 10.14 or later. If you are updating major versions, 10.13 to 10.14 for example, then you'll need to re-install MacPorts and your installed ports using the [Migration Guide](https://trac.macports.org/wiki/Migration).

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

## Run a system check

There is an included script which will do a rough analysis of your machine to see how the current state compares to the expected state when all desired dependencies are installed. It's not comprehensive, so passing the check doesn't guarantee you don't have any problems or unconfigured applications.

The check script is at `bin/macos/check.sh` so if you have cloned the project, you can run this from the project root:

```
./bin/macos/check.sh
```

You can also download `check.sh` idependently and run this from wherever you have downloaded it:

```
./check.sh
```
