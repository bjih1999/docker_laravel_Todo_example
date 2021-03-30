FROM php:7.4-apache

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN apt-get update
RUN apt-get -y install exif
RUN apt-get -y install gettext
RUN apt-get -y install git
RUN apt-get -y install unzip
RUN apt-get -y install libzip-dev
RUN docker-php-ext-install pdo pdo_mysql zip
RUN su
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN composer global require laravel/installer
ENV PATH $PATH:/root/.composer/vendor/bin
RUN laravel new laravel_todo

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN chmod 775 -R /var/www/html/laravel_todo
RUN chown -R $USER:www-data /var/www/html/laravel_todo

CMD ["apachectl", "-D", "FOREGROUND"]
