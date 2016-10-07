# JoseVieira ME - DockerFiles

|Repository                | Images/Tags                   | Description                                        |
|--------------------------|-------------------------------|----------------------------------------------------|
| josevieirame/**php**     | `7.0`, `latest`               | PHP v7.0 without webserver                         |
|                          | `7.0-apache`, `latest-apache` | PHP v7.0 with Apache webserver                     |


> **Understanding the docker-compose compose tool is appreciated in order to use the following configuration files.**

```yml
####
# ATENTION:
# Replace occurences of sandbox with your project's name
####

# v2 sintax
version: '2'

services:
  # PHP
  app:
    image: josevieirame/php:7.0-apache # choose yout tag here
    container_name: sandbox-app
    volumes:
      - .:/var/www/app
    ports:
      - "80:8080"
```
