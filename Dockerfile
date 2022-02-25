# ====================================================================================
#   This container is intended to be configured for serve PHP projects with NGINX.
# ====================================================================================

# Use an official build NGINX runtime as a parent image
# Ref.: https://hub.docker.com/_/nginx/
FROM nginx:latest

LABEL maintainer "Alejandro G. Lagunas <alagunas@coati.com.mx>"

ENV HOST_NAME           agomez.guru
ENV HTTP_ROOT_DIR       /srv/public
ENV LOG_STATUS          off
ENV LOG_NAME            agomez-guru
ENV DEPLOYMENT_STAGE    local
ENV PHP_CONTAINER_NAME  php

# Copy my own configured all purpose NGINX starter version
COPY ./nginx.conf /etc/nginx/nginx.conf

# Copy optimized version NGINX template for use with Laravel 8.x
COPY ./laravel.conf.template /etc/nginx/conf.d/laravel.conf.template

COPY docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]

# Use this command if you need verify the final NGINX configuration:  
# CMD ["nginx", "-t]
CMD ["nginx", "-g", "daemon off;"]

# docker build . --tag agomezguru/nginx:laravel-8x
# End of file