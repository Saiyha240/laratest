FROM php:7.2-cli

WORKDIR /app

ADD . /app

EXPOSE 80

RUN apt-get update \
  && apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

#####################################
# Locale:
#####################################

#RUN locale-gen en_US.UTF-8
#
#ENV LANGUAGE=en_US.UTF-8
#ENV LC_ALL=en_US.UTF-8
#ENV LC_CTYPE=en_US.UTF-8
#ENV LANG=en_US.UTF-8

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

# Source the bash
RUN . ~/.bashrc

RUN composer install

CMD php artisan serve --host=0.0.0.0
