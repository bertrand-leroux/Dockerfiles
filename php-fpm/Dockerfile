ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

ARG APP_NAME
ARG APP_USER=docker
ARG APP_GROUP=docker

SHELL ["/bin/bash", "-c"]

COPY --from=composer:1.10 /usr/bin/composer /usr/local/bin/composer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
COPY ./files/entrypoint.sh /usr/local/bin

RUN apt-get update && apt-get --yes --no-install-recommends --no-install-suggests install \
        acl \
        apt-utils \
        bash-completion \
        dnsutils \
        gnupg \
        procps \
        sudo \
        unzip \
        vim \
        wget \
    && apt-get clean && apt-get --yes autoremove --purge \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/lintian/* /usr/share/locale/* /usr/share/man/* \
    && install-php-extensions \
        amqp \
        apcu \
        apcu_bc \
        bcmath \
        gd \
        intl \
        mongodb \
        pdo_mysql \
        sockets \
        ssh2 \
        xdebug \
        zip \
    && echo "xdebug.mode=debug" >> $PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini \
    && useradd $APP_USER --shell /bin/bash --create-home \
    && usermod --append --groups sudo $APP_GROUP \
    && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && echo 'docker:secret' | chpasswd \
    && chmod +x /usr/local/bin/composer \
    && chmod a+x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

USER ${APP_USER}
WORKDIR /var/www/${APP_NAME}

CMD ["bash"]
