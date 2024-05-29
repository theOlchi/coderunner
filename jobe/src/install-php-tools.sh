#!/bin/bash

echo "## Installing PHP 8.1 ##"
apt-get install -y --no-install-recommends php8.1-pspell php8.1-curl php8.1-gd php8.1-intl php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-ldap php8.1-zip php8.1-soap php8.1-mbstring

echo "## Installing Composer ##"
cd /tmp
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
echo $RESULT

mv composer.phar /usr/local/bin/composer
chown root:root /usr/local/bin/composer
