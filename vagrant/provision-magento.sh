#!/usr/bin/env bash

echo "===================== STARTING MAGENTO PROVISION ====================="


echo "Installing Composer Packages (or updating existing packages) and dumping autoloaders"

echo "Copying over Auth Credentials."

AUTH_CREDENTIALS_PATH=/vagrant/conf/composer/auth.json
if [[ ! -f "$AUTH_CREDENTIALS_PATH" ]]; then
    echo "Auth Credentials do not exist! You will need these to install the Magento Package. Please see auth.json.template, copy to auth.json and edit with your credentials. Then run vagrant provision --provision-with=magento again"
    exit 1
fi

sudo cp $AUTH_CREDENTIALS_PATH /home/vagrant/.config/composer/auth.json

composer create-project --repository=https://repo.magento.com/ magento/project-community-edition /var/www/magento

composer install

sudo chown -R www-data:www-data /var/www/magento

echo "===================== ENDING MAGENTO PROVISION ====================="

exit 0
