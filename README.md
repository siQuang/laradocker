# Setup Local (MacOS) Laravel Development with Docker

## Prerequistes:
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) Installed
- Composer (globally install)

## Edit Docker .env file
- COMPOSE_PROJECT_NAME | Change the container name
- PHPVERSION | Select PHP version
- LOCAL_HTTP_PORT | Change HTTP port
- LOCAL_HTTPS_PORT | Change HTTPS port


## Clone repo from Github to local directory
``` 
cd /User/username/Sites

git clone https://github.com/siquang/laradocker.git 

cd laradocker
```

## Create new Laravel project
```
composer create-project lavarel/laravel src
```

## Or, create a new Laravel project by globally installing the Laravel installer via Composer
```
composer global require laravel/installer

laravel new src
```

## Laravel Artisan command
For all artisan commands, run this in a shell inside the running container
```
docker exec -it laradocker /bin/bash
```