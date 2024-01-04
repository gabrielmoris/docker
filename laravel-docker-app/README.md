# Creating a PHP + Laravel project using docker compose

```yaml
version: "3.8"
services:
  server:
    image: "nginx:stable-alpine" # This is a light image of nginx server
    ports:
      - "8000:80"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/conf.d/default.conf:ro # :ro means "read-only."
  php:
    build:
      context: ./dockerfiles # where is the folder to build
      dockerfile: php.dockerfile # which is the document with the dockerfile information
    volumes:
      - ./src:/var/www/html:delegated # :delegated optimizes the performance of the volume mount by prioritizing the container's performance over consistency
    # ports:
    #   - "3000:9000"  This is not neccessary since nginx knows which port is using php (9000)
  mysql:
    image: mysql:5.7
    env_file:
      - ./env/mysql.env
  composer:
    build:
      context: ./dockerfiles
      dockerfile: composer.dockerfile
    volumes:
      - ./src:/var/www/html
  artisan:
    build:
      context: ./dockerfiles
      dockerfile: php.dockerfile
    volumes:
      - ./src:/var/www/html
    entrypoint: ["php", "/var/www/html/artisan"] # this will override the php.dockerfile executing this file from the laravel folder (./src)
  npm:
    image: node:14
    working_dir: /var/www/html
    entrypoint: ["npm"]
    volumes:
      - ./src:/var/www/html
```

# Start service

## Create the laravel app (./src should be empty)

It is possile to run only one service with docker-compose. It is usefull for utility containers:
`docker-compose run --rm composer create-project --prefer-dist laravel/laravel:^8.0 .`

## in src/.env change the DB connection

```
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=homestead
DB_USERNAME=homestead
DB_PASSWORD=secret
```

## Start main services

adding `--build` will force docker-compose to rebuild the images if sth changes
`docker-compose up -d --build server php mysql`

## start a command with artisan or npm, for example migrate

`docker-compose run --rm artisan migrate`
`docker-compose run --rm npm -v`
