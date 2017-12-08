#!/bin/bash
# install all the debs with mysql & apache 
apt-get update && apt-get upgrade -y && apt-get install -y apache2 wget git  r-base libmysqlclient-dev r-cran-ggplot2 r-cran-plyr r-cran-reshape2 libcairo2-dev curl npm php php-pear php-mysql php-curl libapache2-mod-php php-mcrypt php-json php-xml php-dom apt libcurl4-openssl-dev


### APACHE CONFIG
a2enmod rewrite && service apache2 start
sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/concerto\/web/g' /etc/apache2/sites-enabled/000-default.conf
cat /etc/apache2/apache2.conf | awk '/<Directory \/var\/www\/>/,/AllowOverride None/{sub("None", "All",$0)}{print}' > /etc/apache2/apache2.conf.tmp && mv /etc/apache2/apache2.conf.tmp /etc/apache2/apache2.conf 
 
### INSTALL & CONFIG/PHP
PHP_DATETIMEZONE=${PHP_DATETIMEZONE:-Africa/Cairo} &&  echo "date.timezone=\"$PHP_DATETIMEZONE\"" >> /etc/php/7.0/cli/php.ini

