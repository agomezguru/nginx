#!/usr/bin/env sh
set -eu

envsubst '${HOST_NAME} ${HTTP_ROOT_DIR} ${LOG_STATUS} ${LOG_NAME} ${DEPLOYMENT_STAGE} ${PHP_CONTAINER_NAME}' < /etc/nginx/conf.d/laravel.conf.template > /etc/nginx/conf.d/default.conf

exec "$@"