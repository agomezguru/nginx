#!/usr/bin/env sh
set -eu

envsubst '${HOST_NAME} ${HTTP_ROOT_DIR} ${LOG_STATUS} ${LOG_NAME} ${DEPLOYMENT_STAGE} ${PHP_CONTAINER_NAME} ${CLIENT_BODY_SIZE} ${BUFFERS} ${BUFFER_SIZE}' < /etc/nginx/conf.d/laravel.conf.template > /etc/nginx/conf.d/default.conf

exec "$@"
