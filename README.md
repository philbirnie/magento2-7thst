Magento 2.2 Development Environment
====================================

Author: Phil Birnie, info[at]7thstreetweb.com

## Overview

This repo helps stand up a development environment for new or existing Magento 2.2 implementations. 

## Setup

### Always
`vagrant up`


### First Time Only
Unfortunately, Magento’s Composer package **requires credentials**; otherwise this would be automated, but run this command after the containers have booted:  <br />

`cd vagrant`
`vagrant ssh`
`cd /var/www/magento `
`composer install`

Walk through the [setup script](https://127.0.0.1:8001/setup/).

**Important!** Do _NOT_ use localhost. See: 
https://magento.stackexchange.com/questions/194828/magento-2-new-customer-account-form-not-working/211392#211392

 Get a ☕... This is going to be a while.

##### Development Tips

The dev environment in Magento 2 can be  slow.  Here are some recommendations, many of which were pulled directly from the [Magento documentation](http://devdocs.magento.com/guides/v2.2/extension-dev-guide/build/optimal-dev-environment.html).

1. Disable only FPC and Block Cache.  Leave all others on. Turn all caches on for front-end development or testing
2. Enable only the extensions that you need.  Many of the analytics extensions are completely unnecessary. 
3. Opcache is enabled -- this appears to make a _substantial_ difference. 
4. Under `Stores -> Configuration -> Advanced -> Developer`, bundle and concatenate JS/CSS when feasible.  The excessive number of requests in Docker slows the site down substantially. (Obviously this is not feasible when doing FE work)

### Stack

1. **MySQL:** Percona, 5.7
2. **PHP-FPM:** 7.1
3. **Nginx** 
4. **Ubuntu: 16.4**

### Benchmarks

##### Loading Products Page in Admin (with 0 products)
1. Docker: 29s
2. Vagrant: 2s
