FROM php:7.4-apache

# Installer dépendances nécessaires
RUN apt-get update && \
    apt-get install -y git unzip libpng-dev libjpeg-dev libfreetype6-dev curl ca-certificates && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd mysqli pdo pdo_mysql && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# Cloner PlaySMS
RUN git clone https://github.com/playsms/playsms.git  && \
    cp config-dist.php config.php

# Copier le script d'entrypoint pour config.php
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Droits apache
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
