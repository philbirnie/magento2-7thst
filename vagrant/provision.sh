#!/usr/bin/env bash

echo "===================== LET'S GO.... ====================="

## Install Necessary Packages
apt-get update

# Install nginx
apt-get install -y nginx
echo "===================== NGINX INSTALLATION COMPLETE ====================="


# Install Percona
wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
apt-get update

export DEBIAN_FRONTEND=noninteractive
dbpass="root" && export dbpass
echo percona-server-server-5.7 percona-server-server/root_password password $dbpass | sudo debconf-set-selections
echo percona-server-server-5.7 percona-server-server/root_password_again password $dbpass | sudo debconf-set-selections

apt-get install -y percona-server-server-5.7
echo "===================== PERCONA INSTALLATION COMPLETE ====================="


# Install PHP
add-apt-repository -y ppa:ondrej/php && apt-get update

apt-get -y install php7.1-cli php7.1-fpm php7.1-mysql php7.1-curl php7.1-opcache php7.1-mcrypt php7.1-mbstring php7.1-xsl php7.1-intl php7.1-soap php7.1-zip php7.1-gd

echo "===================== PHP 7.1 INSTALLATION COMPLETE ====================="

# Set up NGINX configuration

# Copy Over Configuration File to conf.d folder
sudo cp /var/www/conf/site.conf /etc/nginx/conf.d

# Copy Over Magento Configuration File
sudo cp /var/www/conf/magento.nginx.conf /etc/nginx/sites-enabled/default

echo "===================== COPIED OVER NGINX FILES... TESTING & RESTARTING ====================="

sudo nginx -t

service nginx restart

# Install Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo "===================== COMPOSER INSTALLED ====================="


echo "===================== SETTING PATH VARIABLE ====================="
echo "export PATH=$PATH:/var/www/magento/bin" >> /home/vagrant/.profile


echo "===================== MAIN PROVISION FILE COMPLETED ====================="

exit 0

