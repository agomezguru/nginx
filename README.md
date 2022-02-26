# Quick reference, nginx

Configured NGINX server for deploy with Laravel 8.x based projects

- **Maintained by**:
[agomezguru](https://github.com/agomezguru)

- **Where to get help**:  
[Docker Official Images: nginx](https://hub.docker.com/_/nginx/)

## Supported tags and respective `Dockerfile` links

- [`laravel-8x`, `latest`](https://github.com/agomezguru/nginx)

## How to use this image

The intent of this image is always being together use with a Laravel 8.x docker container with a simple `Dockerfile` (in `/host/path/`) like this one:

```bash
cat <<EOF > docker-compose.yml
version: '3'

volumes:
  my-public:
    external: true

services:
  web:
    image: agomezguru/nginx:laravel-8x
    ports:
      - "$outsidePort:80"
    environment:
      - HOST_NAME=myAppHostName
      - LOG_STATUS=on
      - LOG_NAME=myAppLogName
      - DEPLOYMENT_STAGE=develop
      - PHP_CONTAINER_NAME=php
    volumes:
      - ../code:/srv
      - my-public:/srv/public
    networks:
      - $env-network

  php:
    image: agomezguru/laravel:8.x-php7.4.x
    volumes:
      - ../code:/srv
      - my-public:/srv/public
      - ./php-composer.ini:/usr/local/etc/php/conf.d/custom.ini
    networks:
      - $env-network

# Isolate docker containers arrays between environments.
networks:
  $env-network:
    driver: bridge
EOF
```

### Using environment variables in nginx configuration

Out-of-the-box, nginx doesn't support environment variables inside most configuration blocks. But `envsubst` has being used inside of this image as a workaround to generate some kind of nginx configuration dynamically before nginx starts.

In the above example you can see this in action:

```yaml
web:
  image: agomezguru/nginx:laravel-8x
  ports:
    - "$outsidePort:80"
  environment:
    - HOST_NAME=myAppHostName
    - LOG_STATUS=on
    - LOG_NAME=myAppLogName
    - DEPLOYMENT_STAGE=develop
    - PHP_CONTAINER_NAME=php
```

## References

Environment [variables in NGINX](https://serverfault.com/questions/577370/how-can-i-use-environment-variables-in-nginx-conf)

Deployment Laravel, [server configuration NGINX](https://laravel.com/docs/5.8/deployment)

Environment variables in Compose, [official documentation](https://docs.docker.com/compose/environment-variables/)

Docker [RUN vs CMD vs ENTRYPOINT](https://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/)

## License

View [license information](http://nginx.org/LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
