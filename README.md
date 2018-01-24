Magento 2.2 Development Environment
====================================

Author: Phil Birnie, info[at]7thstreetweb.com

## Overview

## Setup

### Always
1. `docker-compose up`

### First Time Only
2. Unfortunately, Magento’s Composer package **requires credentials**; otherwise this would be automated, but run this command after the containers have booted:  <br />
 <h5>Fresh Install</h5>
`docker-compose exec php /var/www/composer.phar create-project --ignore-platform-reqs --repository-url=https://repo.magento.com/ magento/project-community-edition .`<br />
 <h5>Existing Install</h5>
 `docker-compose exec php /var/www/composer.phar install` <br/>
 Either way, get a ☕... This is going to be a while.


### Stack

1. **MySQL:** Percona, 5.7
2. **PHP-FPM:** FPM-Stretch, 7.2
2. **Nginx** 
