#!/bin/bash
rm -f /run/httpd/httpd.pid

# Starts FPM
#/usr/sbin/php-fpm7.0 -F -O 2>&1 | sed -u 's,.*: \"\(.*\)$,\1,'| sed -u 's,"$,,' 1>&1
/usr/sbin/php-fpm -F -O  &

# Starts apache2!
/usr/sbin/httpd -D FOREGROUND
