#!/usr/bin/env bash

exists() {
  command -v "$1" >/dev/null 2>&1
}

usecases() {
  if [ -v "USE_CASES[$1]" ]; then
    echo "Use cases:"
    echo "${USE_CASES[$1]}"
  fi
}

if [ "$(which bash)" != "/opt/local/bin/bash" ]; then
  echo ""
  echo -e "\033[91mWarning:\033[0m"
  echo "Your bash installation is not in the expected location."
  echo "Expected: /opt/local/bin/bash"
  echo "Actual:   $(which bash)"
  echo "This script may not work as expected."
fi

if ! exists port; then
  echo ""
  echo -e "Macports (port): \033[91mnot found\033[0m"
  echo ""
  exit 1
fi

PORTS+=( ansible )
PORTS+=( apache2 )
PORTS+=( bash )
PORTS+=( bash-completion )
PORTS+=( erlang )
PORTS+=( git )
PORTS+=( ImageMagick )
PORTS+=( jslint )
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
PORTS+=( unixODBC )
PORTS+=( unrar )
PORTS+=( watch )
PORTS+=( wget )

COMMANDS+=( apachectl )
COMMANDS+=( chromedriver )
COMMANDS+=( composer )
COMMANDS+=( mailcatcher )
COMMANDS+=( mongo )
COMMANDS+=( mysql )
COMMANDS+=( node )
COMMANDS+=( npm )
COMMANDS+=( nvm )
COMMANDS+=( smysqldump )

declare -A PATHS
PATHS[apachectl]=/opt/local/sbin/apachectl
PATHS[bash]=/opt/local/bin/bash
PATHS[chromedriver]=/opt/local/bin/chromedriver
PATHS[composer]=/opt/local/bin/composer
PATHS[mailcatcher]=~/.rbenv/shims/mailcatcher
PATHS[node]=~/.nvm/versions/node/v11.10.1/bin/node
PATHS[npm]=~/.nvm/versions/node/v11.10.1/bin/npm

FILES+=( /opt/MongooseIM )
FILES+=( /Library/Developer/CommandLineTools/usr/bin/clang )

declare -A USE_CASES
USE_CASES[ansible]="Running this ansible playbook."
USE_CASES[chromedriver]="Automated browser testing.\nUsed by Behat, Intern, and Selenium."
USE_CASES[composer]="PHP package/dependency manager."
USE_CASES[erlang]="MongooseIM dependency."
USE_CASES[ImageMagick]="Resizing images (thumbnails, image styles)."
USE_CASES[jslint]="Javascript linter."
USE_CASES[mailcatcher]="Local SMTP server for email testing."
USE_CASES[npm]="Node.js package/dependency manager."
USE_CASES[rbenv]="Ruby environment dependency.\nmailcatcher and fastlane are ruby applications."
USE_CASES[ruby-build]=USE_CASES[rbenv]
USE_CASES[smysqldump]="Download SQL dumps from remote databases over SSH."
USE_CASES[unixODBC]="MongooseIM dependency.\nMS SQL Server / ODBC dependency."
USE_CASES[/opt/MongooseIM]="XMPP applications such as chat."

# TODO:
# xcode, latex, fastlane, react-native

source ~/.bash_profile
source ~/.bashrc

echo -e "\nChecking installed ports...\n"

INSTALLED_PORTS=$(port installed)

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
    echo -e "$K: \033[91m$(which $K)\033[0m"
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
