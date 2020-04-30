FROM php:7.4.5-zts-alpine3.11

LABEL maintainer="Liruizhao <liruizhaoatphp@outlook.com>" version="1.0"

ENV PHP_DEPS="bzip2-dev bzip2 libcurl curl-dev libxml2 libxml2-dev enchant enchant-dev"
ENV PHP_EXT_OPTS="bcmath bz2 calendar ctype curl dba dom enchant exif ffi fileinfo filter ftp gd gettext gmp hash iconv imap intl json ldap mbstring mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline reflection session shmop simplexml snmp soap sockets sodium spl standard sysvmsg sysvsem sysvshm tidy xmlreader xmlrpc xmlwriter xsl zend_test zip"

##
# ---------- building ----------
##
RUN set -ex \
    # change apk source repo
    && apk add --no-cache ${PHP_DEPS} \
    && docker-php-source extract \
    && docker-php-ext-install ${PHP_EXT_OPTS} \
    && docker-php-ext-enable ${PHP_EXT_OPTS} \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man \
    && php -v \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
