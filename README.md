Magento 2.2 Development Environment
====================================

Author: Phil Birnie, info[at]7thstreetweb.com

## Overview

## Setup

### Always
`docker-compose up`

### First Time Only
Unfortunately, Magento’s Composer package **requires credentials**; otherwise this would be automated, but run this command after the containers have booted:  <br />

##### Fresh Install

`docker-compose exec php /var/www/composer.phar create-project --ignore-platform-reqs --repository-url=https://repo.magento.com/ magento/project-community-edition .`

##### Existing Install

`docker-compose exec php /var/www/composer.phar install`

 Either way, get a ☕... This is going to be a while.


### Stack

1. **MySQL:** Percona, 5.7
2. **PHP-FPM:** FPM-Apline, 7.1
2. **Nginx** 
