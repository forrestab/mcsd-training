#!/usr/bin/env bash

echo "Provisioning virtual machine ..."

echo "Updating packages ..."
apt-get update >/dev/null 2>&1

echo "Installing base packages ..."
apt-get install -y curl >/dev/null 2>&1

echo "Installing and configuring apache ..."
apt-get install -y apache2 >/dev/null 2>&1
# Remove /var/www path
rm -rf /var/www >/dev/null 2>&1
# Symbolic link to /vagrant path
ln -fs /vagrant /var/www >/dev/null 2>&1
a2enmod rewrite >/dev/null 2>&1
# Replace every instance of /var/www/html with /var/www in 000-default site
sed -i 's_/var/www/html_/var/www_g' /etc/apache2/sites-available/000-default.conf >/dev/null 2>&1
a2dissite 000-default >/dev/null 2>&1
a2ensite 000-default >/dev/null 2>&1

echo "Restarting apache ..."
service apache2 restart >/dev/null 2>&1
