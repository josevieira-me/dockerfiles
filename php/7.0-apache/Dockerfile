#####
# Josevieirame/php
# PHP 7.0 bundled with the Apache2 Web webserver
######
FROM josevieirame/php:7.0

# Repository/Image Maintainer
MAINTAINER José Vieira <hello@josevieira.me>

# Reset user to root to allow software install
USER root

# Install httpd from official repositories
RUN echo "---> Installing apache httpd" && \
    yum install -y httpd && \
    sed -i "/Listen 80/c\Listen 8080" /etc/httpd/conf/httpd.conf && \
    echo "--> Cleaning up" && \
    yum clean all -y && \
    yum autoremove -y && \
    rm -rf /tmp/* /var/tmp/* /usr/share/doc/* && \
    echo "--> Fixing permissions" && \
    chown -R php-user:php-user /var/run/httpd && \
    chown -R php-user:php-user /run/httpd && \
    chown -R php-user:php-user /var/log/httpd

# Copy apache, fastcgi and entry script
COPY vhost.conf /etc/httpd/conf.d/vhost.conf
COPY start.sh  /home/php-user/start.sh

RUN chmod +x /home/php-user/start.sh && \
    chown -R php-user:php-user /home/php-user

# Define the running user
USER php-user

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 8080

# Starts a single shell script that puts php-fpm as a daemon and apache2 on foreground
CMD ["/home/php-user/start.sh"]
