FROM ubuntu:14.04

RUN apt-get -qq update
RUN apt-get -qqy upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install apache2 curl lynx-cur inotify-tools

# @PHP_INSTALL@
# @MYSQL_INSTALL@

RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Define mountable directories.
VOLUME ["/data", "/etc/apache2/sites-enabled", "/etc/apache2/sites-available", "/var/log/apache2"]

# Define working directory.
WORKDIR /etc/apache2

CMD run-parts /var/local/apache/startup.d && exec apache2 -D FOREGROUND

# Expose ports.
EXPOSE 80
EXPOSE 443
