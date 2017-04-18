#!/bin/bash
# A simple script
update-rc.d mysql defaults
service apache2 start
service mysql start
tail -f /dev/null
