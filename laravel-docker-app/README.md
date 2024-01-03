# Creating a PHP + Laravel project using docker compose

```yaml
version: "3.8"
services:
  server:
    image: "nginx:stable-alpine" # This is a light image of nginx server
    ports:
      - "8000:80"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro # :ro means "read-only."
  php:
    build:
      context: ./dockerfiles # where is the folder to build
      dockerfile: php.dockerfile # which is the document with the dockerfile information
    volumes:
      - ./src:/var/www/html:delegated # :delegated optimizes the performance of the volume mount by prioritizing the container's performance over consistency
    # ports:
    #   - "3000:9000"  This is not neccessary since nginx knows which port is using php (9000)
  mysql:
```
