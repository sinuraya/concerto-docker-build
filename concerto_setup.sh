#!/bin/bash

## setup everything related to concerto 
MYSQL_ROOT_PASSWORD=${CONCERTO_MYSQL}
### concerto config 
chown -R www-data /var/www
git clone https://github.com/campsych/concerto-platform.git
cd concerto-platform
if [ "$CONCERTO_COMMIT" = "default" ]; then ## choose a commit to build on
  echo "no commit  found moving with the latest NOT RECOMMENDED"
else
  echo ${CONCERTO_COMMIT}
  echo "found a commit"
  git checkout ${CONCERTO_COMMIT}

fi
cd ..
mv concerto-platform /var/www/html/concerto ## change this with the version you want ##  -b dev --single-branch





cp /var/www/html/concerto/app/config/parameters.yml.dist /var/www/html/concerto/app/config/parameters.yml && \
    cp /var/www/html/concerto/app/config/parameters_nodes.yml.dist /var/www/html/concerto/app/config/parameters_nodes.yml && \
    cp /var/www/html/concerto/app/config/parameters_test_runner.yml.dist /var/www/html/concerto/app/config/parameters_test_runner.yml && \
    cp /var/www/html/concerto/app/config/parameters_uio.yml.dist /var/www/html/concerto/app/config/parameters_uio.yml

sed -i 's/database_port: .*$/database_port: 3306/g' /var/www/html/concerto/app/config/parameters.yml && \
    sed -i 's/database_name: .*$/database_name: concerto/g' /var/www/html/concerto/app/config/parameters.yml && \
    sed -i 's/database_user: .*$/database_user: root/g' /var/www/html/concerto/app/config/parameters.yml && \
    sed -i "s/database_password: .*$/database_password: $MYSQL_ROOT_PASSWORD/g" /var/www/html/concerto/app/config/parameters.yml && \
    sed -i 's/test_database_port: .*$/database_port: null/g' /var/www/html/concerto/app/config/parameters.yml && \
    sed -i 's/test_database_name: .*$/database_name: concerto_test/g' /var/www/html/concerto/app/config/parameters.yml && \
    sed -i 's/test_database_user: .*$/database_user: null/g' /var/www/html/concerto/app/config/parameters.yml && \
    sed -i "s/test_database_password: .*$/database_password: null/g" /var/www/html/concerto/app/config/parameters.yml


##  php config part
cd /var/www/html/concerto && curl  -s http://getcomposer.org/installer | php
cd /var/www/html/concerto && php   -dmemory_limit=1G composer.phar install --prefer-source --no-interaction


## bower part
npm install -g bower && ln -s /usr/bin/nodejs /usr/bin/node && \
    cd /var/www/html/concerto/src/Concerto/PanelBundle/Resources/public/angularjs && bower install --allow-root && \
    cd /var/www/html/concerto/src/Concerto/TestBundle/Resources/public/angularjs && bower install --allow-root

## start mysql
service mysql start

## final setup
cd /var/www/html/concerto/src/Concerto/TestBundle/Resources/R && R CMD INSTALL concerto5
php /var/www/html/concerto/app/check.php ## CHECK that everything is ok
cd /var/www/html/concerto && php app/console concerto:setup
cd /var/www/html/concerto && php app/console concerto:r:cache
chown -R www-data:www-data /var/www/html/concerto
cd /var/www/html/concerto && php app/console concerto:content:import --convert
