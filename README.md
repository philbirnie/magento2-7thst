Magento 2.2 Development Environment
====================================

Author: Phil Birnie, info[at]7thstreetweb.com

## Overview

This repo helps stand up a development environment for new or existing Magento 2.2 implementations. 

## Setup

### Always
`docker-compose up`

### First Time Only
Unfortunately, Magento’s Composer package **requires credentials**; otherwise this would be automated, but run this command after the containers have booted:  <br />

##### Fresh Install

`docker-compose exec php /var/www/composer.phar create-project --ignore-platform-reqs --repository-url=https://repo.magento.com/ magento/project-community-edition .`

Walk through the [setup script](http://localhost:8000/setup/).

##### Existing Install

Place your existing install in a `magento` folder

`docker-compose exec php /var/www/composer.phar install` 

 Either way, get a ☕... This is going to be a while.

##### Development Tips

The dev environment in Magento 2 can be painfully slow.  Here are some recommendations, many of which were pulled directly from the [Magento documentation](http://devdocs.magento.com/guides/v2.2/extension-dev-guide/build/optimal-dev-environment.html).

1. Disable only FPC and Block Cache.  Leave all others on. Turn all caches on for front-end development or testing
2. Enable only the extensions that you need.  Many of the analytics extensions are completely unnecessary. 
3. Opcache is enabled -- this appears to make a _substantial_ difference. 

### Stack

1. **MySQL:** Percona, 5.7
2. **PHP-FPM:** FPM-Apline, 7.1
2. **Nginx** 
