FROM php:5.6-apache
MAINTAINER Jens Erat <email@jenserat.de>

# Remove SUID programs
RUN for i in `find / -perm +6000 -type f`; do chmod a-s $i; done

# selfoss requirements: mod-headers, mod-rewrite, gd
RUN a2enmod headers rewrite && \
    apt-get update && \
    apt-get install -y --no-install-recommends unzip libpng12-dev libpq-dev cron && \
    docker-php-ext-install gd mbstring pdo_pgsql pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/SSilence/selfoss/releases/download/2.15/selfoss-2.15.zip /tmp/
RUN unzip /tmp/selfoss-*.zip -d /var/www/html && \
    rm /tmp/selfoss-*.zip && \
    ln -s /var/www/html/data/config.ini /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Create the cron-job
RUN echo "*/15 *  * * *  root  curl -s http://localhost/update\n" >> /etc/crontab

VOLUME /var/www/html/data

# Extend maximum execution time, so /refresh does not time out
COPY php.ini /usr/local/etc/php/

ENTRYPOINT ["cron && apache2-foreground"]
