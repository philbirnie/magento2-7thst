#!/usr/bin/env bash

echo "===================== LET'S GO.... ====================="

## Install Necessary Packages
apt-get update

# Install nginx
apt-get install -y nginx

echo "Adding www-data user to vagrant group and vice versa"

# Syntax usermod add -a -G GROUP USER
usermod -a -G vagrant www-data
usermod -a -G www-data vagrant

echo "===================== NGINX INSTALLATION COMPLETE ====================="


# Install Percona
wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb
dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb
apt-get update

export DEBIAN_FRONTEND=noninteractive
dbpass="root" && export dbpass
echo percona-server-server-5.7 percona-server-server/root_password password $dbpass | sudo debconf-set-selections
echo percona-server-server-5.7 percona-server-server/root_password_again password $dbpass | sudo debconf-set-selections

apt-get install -y percona-server-server-5.7
echo "===================== PERCONA INSTALLATION COMPLETE ====================="


# Install PHP
add-apt-repository -y ppa:ondrej/php && apt-get update

apt-get -y install php7.2-cli php7.2-fpm php7.2-mysql php7.2-curl php7.2-opcache php7.2-mbstring php7.2-xsl php7.2-intl php7.2-soap php7.2-zip php7.2-gd php7.2-bcmath php-xdebug

# Copy over PHP Configuration
sudo cp /vagrant/conf/php/xdebug.ini /etc/php/7.2/mods-available/xdebug.ini
sudo mv /etc/php/7.2/fpm/pool.d/www.conf /etc/php/7.2/fpm/pool.d/www.conf.bak
sudo cp /vagrant/conf/php/www.conf /etc/php/7.2/fpm/pool.d/www.conf

echo "===================== PHP 7.2 INSTALLATION COMPLETE ====================="

# Set up NGINX configuration

# Make Web Directory

mkdir /var/www/magento
chown vagrant:vagrant /var/www/magento
chmod 755 /var/www/magento

# Copy Over Configuration File to conf.d folder
sudo cp /vagrant/conf/nginx/site.conf /etc/nginx/conf.d

# Copy Over SSL Params File to conf.d folder
sudo cp /vagrant/conf/nginx/ssl-params.conf /etc/nginx/snippets/

# Copy Over Magento Configuration File
sudo cp /vagrant/conf/nginx/magento.nginx.conf /etc/nginx/sites-enabled/default

echo "===================== COPIED OVER NGINX FILES... TESTING & RESTARTING ====================="

sudo nginx -t

service nginx restart

# Install Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo "===================== COMPOSER INSTALLED ====================="


echo "===================== SETTING PATH VARIABLE ====================="
echo "export PATH=$PATH:/var/www/magento/bin" >> /home/vagrant/.profile


echo "====================== INSTALLING SELF SIGNED CERTIFICATE ==================="

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -subj "/C=US/ST=Ohio/L=Worthington/O=Global Security/OU=IT Department/CN=magento2@magento.com" -out /etc/ssl/certs/nginx-selfsigned.crt

openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

echo "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;" > /etc/nginx/snippets/self-signed.conf
echo "ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" >> /etc/nginx/snippets/self-signed.conf

echo "================ CERTIFICATE INSTALLED; TESTING AND RESTARTING NGINX ==============="

sudo nginx -t

service nginx restart


echo "===================== MAIN PROVISION FILE COMPLETED ====================="

exit 0

