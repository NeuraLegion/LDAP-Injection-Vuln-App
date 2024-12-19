FROM php:7.4-apache

RUN  echo 'Acquire::AllowInsecureRepositories "true";' > /etc/apt/apt.conf.d/99insecure && \
     echo 'Acquire::Check-Valid-Until "false";' >> /etc/apt/apt.conf.d/99insecure && \
     echo 'Acquire::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/99insecure && \
     apt-get update && \
     apt-get install -y --no-install-recommends libldap2-dev && \
     apt-get clean && \
     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-configure ldap --with-libdir=lib && \
     docker-php-ext-install ldap
ADD ./src/public /var/www/html/
