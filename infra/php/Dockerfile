FROM node:14-buster as node
FROM php:8.0.3-apache-buster
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

# timezone environment
ENV TZ=Asia/Tokyo \
  # locale
  LANG=ja_JP.UTF-8 \
  LANGUAGE=ja_JP:en \
  LC_ALL=ja_JP.UTF-8 \
  # composer environment
  COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer

# composer command
COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer
# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt

RUN apt-get update && \
  apt-get -y install vim cron git libicu-dev libonig-dev libzip-dev unzip locales \
  libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
  apt-get install -y libxrender1 libfontconfig1 libxext6 libssl1.1 fonts-ipafont fonts-thai-tlwg fonts-lohit-deva-nepali && \
  docker-php-ext-configure gd --with-freetype --with-jpeg && \
  docker-php-ext-install -j$(nproc) gd && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  locale-gen ja_JP.UTF-8 && \
  localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
  a2enmod rewrite && \
  docker-php-ext-install intl pdo_mysql zip bcmath && \
  composer config -g process-timeout 3600 && \
  composer config -g repos.packagist composer https://packagist.org

COPY ./infra/php/php.ini /usr/local/etc/php/php.ini
COPY ./infra/apache/httpd.conf /etc/apache2/sites-available/000-default.conf
COPY ./infra/cron/root /etc/cron.d/cron

WORKDIR /work/backend
