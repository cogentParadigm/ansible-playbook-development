#!/usr/bin/env bash

exists() {
  command -v "$1" >/dev/null 2>&1
}

version_gt() {
  test "$(printf '%s\n' "$@" | sort --version-sort | head -n 1)" != "$1";
}

usecases() {
  if [ -v "USE_CASES[$1]" ]; then
    echo "Use cases:"
    echo -e "${USE_CASES[$1]}"
  fi
}

if [ "$SHELL" != "/opt/local/bin/bash" ]; then
  echo ""
  echo -e "\033[91mWarning:\033[0m"
  echo "MacPorts bash is not set as your default shell."
  echo "Expected: /opt/local/bin/bash"
  echo "Actual:   $SHELL"
  echo "This script may not work as expected."
fi

OS_VERSION=$(defaults read loginwindow SystemVersionStampAsString)
TARGET_OS_VERSION="10.14.4"

XCODE_VERSION=$(xcodebuild -version | awk 'NR==1{print $2}')
TARGET_XCODE_VERSION="10.2"

PORTS+=( py-ansible )
PORTS+=( apache2 )
PORTS+=( bash )
PORTS+=( bash-completion )
PORTS+=( erlang )
PORTS+=( git )
PORTS+=( ImageMagick )
PORTS+=( mariadb-10.2-server )
PORTS+=( mongodb )
PORTS+=( mongo-tools )
PORTS+=( php56 )
PORTS+=( php56-apache2handler )
PORTS+=( php56-curl )
PORTS+=( php56-exif )
PORTS+=( php56-gd )
PORTS+=( php56-iconv )
PORTS+=( php56-imagick )
PORTS+=( php56-intl )
PORTS+=( php56-mbstring )
PORTS+=( php56-mcrypt )
PORTS+=( php56-memcached )
PORTS+=( php56-mongo )
PORTS+=( php56-mysql )
PORTS+=( php56-openssl )
PORTS+=( php56-pcntl )
PORTS+=( php56-pdflib )
PORTS+=( php56-soap )
PORTS+=( php56-xdebug )
PORTS+=( php56-xhprof )
PORTS+=( php56-zip )
PORTS+=( php71 )
PORTS+=( php71-apache2handler )
PORTS+=( php71-curl )
PORTS+=( php71-exif )
PORTS+=( php71-fpm )
PORTS+=( php71-gd )
PORTS+=( php71-gmp )
PORTS+=( php71-iconv )
PORTS+=( php71-imagick )
PORTS+=( php71-intl )
PORTS+=( php71-mbstring )
PORTS+=( php71-mcrypt )
PORTS+=( php71-mongodb )
PORTS+=( php71-mysql )
PORTS+=( php71-openssl )
PORTS+=( php71-pear )
PORTS+=( php71-posix )
PORTS+=( php71-soap )
PORTS+=( php71-xdebug )
PORTS+=( php71-yaml )
PORTS+=( php71-zip )
PORTS+=( rbenv )
PORTS+=( ruby-build )
PORTS+=( texlive )
PORTS+=( texlive-latex-extra )
PORTS+=( unixODBC )
PORTS+=( unrar )
PORTS+=( watch )
PORTS+=( wget )
PORTS+=( wkhtmltopdf )

COMMANDS+=( apachectl )
COMMANDS+=( chromedriver )
COMMANDS+=( code )
COMMANDS+=( composer )
COMMANDS+=( fastlane )
COMMANDS+=( mailcatcher )
COMMANDS+=( mongo )
COMMANDS+=( mysql )
COMMANDS+=( node )
COMMANDS+=( react-native )
COMMANDS+=( npm )
COMMANDS+=( nvm )
COMMANDS+=( smysqldump )
COMMANDS+=( xcodebuild )

declare -A PATHS
PATHS[apachectl]=/opt/local/sbin/apachectl
PATHS[bash]=/opt/local/bin/bash
PATHS[chromedriver]=/opt/local/bin/chromedriver
PATHS[composer]=/opt/local/bin/composer
PATHS[mailcatcher]=~/.rbenv/shims/mailcatcher
PATHS[mysql]=/opt/local/lib/mariadb-10.2/bin/mysql
PATHS[node]=~/.nvm/versions/node/v11.10.1/bin/node
PATHS[npm]=~/.nvm/versions/node/v11.10.1/bin/npm

FILES+=( /opt/MongooseIM )
FILES+=( /Library/Developer/CommandLineTools/usr/bin/clang )

declare -A USE_CASES
USE_CASES[py-ansible]="Running this ansible playbook."
USE_CASES[chromedriver]="Automated browser testing.\nUsed by Behat, Intern, and Selenium."
USE_CASES[composer]="PHP package/dependency manager."
USE_CASES[erlang]="MongooseIM dependency."
USE_CASES[ImageMagick]="Resizing images (thumbnails, image styles)."
USE_CASES[mailcatcher]="Local SMTP server for email testing."
USE_CASES[npm]="Node.js package/dependency manager."
USE_CASES[rbenv]="Ruby environment dependency.\nmailcatcher and fastlane are ruby applications."
USE_CASES[ruby-build]=${USE_CASES[rbenv]}
USE_CASES[smysqldump]="Download SQL dumps from remote databases over SSH."
USE_CASES[unixODBC]="MongooseIM dependency.\nMS SQL Server / ODBC dependency."
USE_CASES[/opt/MongooseIM]="XMPP applications such as chat."

# source ~/.bash_profile
# source ~/.bashrc

echo -e "\nChecking Mac OS version...\n"
echo "Installed version: $OS_VERSION"
echo "Target version:    $TARGET_OS_VERSION"

if version_gt $TARGET_OS_VERSION $OS_VERSION; then
  echo -e "\n\033[91mYour OS version is not up to date.\033[0m"
  echo -e "\nIf you have outdated applications, do not attempt to update major OS versions and applications at the same time."
  echo -e "Under most circumstances, the best course of actions is to update your OS version first."
  echo -e "Follow the MacPorts migration guide to reinstall your ports:"
  echo "https://trac.macports.org/wiki/Migration"
  echo "This does not apply to minor version upgrades."
else
  echo -e "\n\033[92mYour OS version is up to date.\033[0m"
fi

echo -e "\nChecking Xcode version...\n"
echo "Installed version: $XCODE_VERSION"
echo "Target version:    $TARGET_XCODE_VERSION"

if version_gt $TARGET_XCODE_VERSION $XCODE_VERSION; then
  echo -e "\n\033[91mYour Xcode version is not up to date.\033[0m"
else
  echo -e "\n\033[92mYour Xcode version is up to date.\033[0m"
fi

echo -e "\nChecking installed ports...\n"

if ! exists port; then
  echo -e "port: \033[91mnot found\033[0m"
  echo -e "\nUnable to determine installed ports because MacPorts is not installed.\n"
  INSTALLED_PORTS=""
else
  INSTALLED_PORTS=$(port installed)
fi

for PORT in "${PORTS[@]}"; do
  if echo "$INSTALLED_PORTS" | grep -q $PORT; then
    echo -e "$PORT: \033[92minstalled\033[0m"
  else
    echo -e "$PORT: \033[91mnot installed\033[0m"
    usecases $PORT
  fi
done

echo -e "\nChecking specific commands...\n"

for COMMAND in "${COMMANDS[@]}"; do
  if exists $COMMAND; then
    echo -e "$COMMAND: \033[92minstalled\033[0m"
  else
    echo -e "$COMMAND: \033[91mnot installed\033[0m"
    usecases $COMMAND
  fi
done

echo -e "\nChecking specific command paths...\n"

for K in "${!PATHS[@]}"; do
  if [ "$(which $K)" == "${PATHS[$K]}" ]; then
    echo -e "$K: \033[92m$(which $K)\033[0m"
  else
    if [ "$(which $K)" == "" ]; then
      echo -e "$K: \033[91mnot installed\033[0m"
    else
      echo -e "$K: \033[91m$(which $K)\033[0m"
    fi
    usecases $K
  fi
done

echo -e "\nChecking specific file/directory paths...\n"

for FILE in "${FILES[@]}"; do
  if test -f "$FILE"; then
    echo -e "$FILE: \033[92mfound\033[0m"
  else
    echo -e "$FILE: \033[91mnot found\033[0m"
    usecases $FILE
  fi
done

echo -e "\nSystem check completed.\n"
