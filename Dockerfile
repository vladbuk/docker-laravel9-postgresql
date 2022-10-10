FROM php:8.1-apache
RUN apt-get update && apt-get install -y apt-utils && a2enmod rewrite && a2enmod headers
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions gd zip bcmath pgsql pdo_pgsql intl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
WORKDIR /var/www/html
RUN usermod -u 1000 www-data
EXPOSE 80

