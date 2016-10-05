#####
# Josevieirame/php
# Centos 7 as Base Image (remi PHP builds)
######
FROM centos:7

# Repository/Image Maintainer
MAINTAINER José Vieira <hello@josevieira.me>

RUN sed -i 's/^mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's/^#baseurl/baseurl/' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's/^mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-fasttrack.repo && \
    sed -i 's/^#baseurl/baseurl/' /etc/yum.repos.d/CentOS-fasttrack.repo

# Install PHP From Remi, Common Extensions, Composer and then cleanup
RUN echo "---> Updating Repository" && \
    yum install -y curl \
    wget \
    nano \
    epel-release \
    sudo && \
    yum update -y

RUN echo "---> Preparing and Installing PHP and Composer" && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum --enablerepo=remi,remi-php70 install -y \
      php-dbg \
      php-fpm \
      php-pdo \
      php-sqlsrv \
      php-apcu \
      php-cli \
      php-json \
      php-mbstring \
      php-mcrypt \
      php-mysql \
      php-mongodb \
      php-opcache \
      php-pgsql \
      php-redis \
      php-soap \
      php-xdebug \
      php-xml \
      php-zip \
      php-gd \
      php-imap \
      php-intl \
      php-sqlite3 \
      php-memcache \
      php-memcached \
      composer && \
      echo "---> Cleaning up" && \
      yum clean all -y && \
      yum autoremove -y && \
      rm -rf /tmp/* /var/tmp/* /usr/share/doc/*

RUN echo "---> Adding the php-user" && \
    adduser -c "" php-user && \
    mkdir -p /var/www/app && \
    chown -R php-user:php-user /var/www

RUN echo "---> Configuring PHP" && \
    usermod -aG wheel php-user && \
    passwd -d php-user && \
    sed -i "/user = .*/c\user = php-user" /etc/php-fpm.d/www.conf && \
    sed -i "/group = .*/c\group = php-user" /etc/php-fpm.d/www.conf && \
    sed -i "/listen-user = .*/c\listen-user = php-user" /etc/php-fpm.d/www.conf && \
    sed -i "/listen-group = .*/c\listen-group = php-user" /etc/php-fpm.d/www.conf && \
    sed -i "/listen = .*/c\listen = [::]:9000" /etc/php-fpm.d/www.conf && \
    sed -i "/;access.log = .*/c\access.log = /proc/self/fd/2" /etc/php-fpm.d/www.conf && \
    sed -i "/;clear_env = .*/c\clear_env = no" /etc/php-fpm.d/www.conf && \
    sed -i "/;catch_workers_output = .*/c\catch_workers_output = yes" /etc/php-fpm.d/www.conf && \
    sed -i "/pid = .*/c\;pid = /run/php/php7.0-fpm.pid" /etc/php-fpm.conf && \
    sed -i "/;daemonize = .*/c\daemonize = yes" /etc/php-fpm.conf && \
    sed -i "/error_log = .*/c\error_log = /proc/self/fd/2" /etc/php-fpm.conf && \
    sed -i "/post_max_size = .*/c\post_max_size = 1024M" /etc/php.ini && \
    sed -i "/upload_max_filesize = .*/c\upload_max_filesize = 1024M" /etc/php.ini && \
    sed -i "/zend_extension=xdebug.so/c\;zend_extension=xdebug.so" /etc/php.d/15-xdebug.ini

# Define the running user
USER php-user

# Application directory
WORKDIR "/var/www/app"

ENV PATH=/home/php-user/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# As non daemon and single base image, it may be used as cli container
CMD ["/bin/bash"]
