# ====================================================================================
#   This container is intended to be configured for serve PHP projects with NGINX.
# ====================================================================================

# Use an NGINX Chainguard Image runtime as a parent image
# Ref.: https://edu.chainguard.dev/chainguard/chainguard-images/reference/nginx/
FROM cgr.dev/chainguard/nginx:latest

LABEL maintainer "Alejandro G. Lagunas <alagunas@coati.com.mx>"

# Set default values for the NGINX config file.
# Note from parent image maintainers: Environment Variable Substitution 
# The Docker official image has support for setting environment variables that get substitued into
# the config file. Currently we do not have support for this, but are looking into options.
ENV HOST_NAME           agomez.guru
ENV HTTP_ROOT_DIR       /srv/public
ENV LOG_STATUS          off
ENV LOG_NAME            agomez-guru
ENV DEPLOYMENT_STAGE    local
ENV PHP_CONTAINER_NAME  php
ENV CLIENT_BODY_SIZE    512M
ENV BUFFERS             16
ENV BUFFER_SIZE         32

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

# docker build . --tag agomezguru/nginx:laravel-cgr-8x
# End of file
