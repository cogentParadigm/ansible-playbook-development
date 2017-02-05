#!/usr/bin/env bash

# This script requires the xcode command line tools to be installed
if [ ! -f "/etc/paths.d/00-macports" ]; then
	export PATH=/opt/local/bin:$PATH
	echo "/opt/local/bin" | sudo tee -a /etc/paths.d/00-macports
fi

which port
if [[ $? != 0 ]] ; then
	echo "MacPorts Installation"
	curl -O https://github.com/macports/macports-base/releases/download/v2.4.0/MacPorts-2.4.0-10.12-Sierra.pkg
	sudo installer -verbose -pkg MacPorts-2.4.0-10.12-Sierra.pkg -target /
	sudo /opt/local/bin/port -v selfupdate
	read -p "Continue ? [Enter]"
	echo ""
fi

if [ ! -f "/Library/Developer/CommandLineTools/usr/bin/clang" ]; then
	echo "XCode Tools Installation"
	echo "This will open up a modal window ... Get back here when ready !"
	sudo /usr/bin/xcode-select --install
	read -p "Continue ? [Enter]"
	echo ""
fi

which ansible
if [[ $? != 0 ]] ; then
	echo "Ansible Installation"
	sudo /opt/local/bin/port install ansible
	read -p "Continue ? [Enter]"
	echo ""
fi

read -p "Your mac is prepared, now restart your terminal"
read -p "Continue ? [Enter]"
exit