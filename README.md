# Laravel with Docker
This is for Laravel local development with Docker Compose. The idea came from Sprintcube LAMP stack with Docker Compose. This built consists of PHP (8.2, 8.1, 8.0, 7.4, 7.3, 7.2), Apache and MariaDB (10.6, 10.5, 10.4, 10.3). Set the version needed in .env file. 

You can have the project up and running in a few minutes.
- Clone this git repository and CD into the project diretory
- Type: ```make env``` and change the environment to your specification
- Type ```make project``` to build container and create a Laravel project

And that's' it! Direct your browser to http://localhost

## Prerequistes:
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- Makefile

## Clone repo from Github to local directory
Rename your project to anything you want
``` 
git clone https://github.com/siquang/laradocker.git laravel-app

cd laravel-app
```

## Makefile Commands
These are some of the Makefile commands to use with your development. For more commands look in Makefile file.

Usage: **make COMMAND**

| Command   | Description                             |
| --------- | :---------------------------------------|
| env       | Copy .env-laradocker to .env            |
| project   | Build Docker and create Laravel project |
| build     | Build Docker container                  |
| up        | Bring up Docker container               |
| down      | Bring down Docker container             |
| exec      | Execute a command inside container      |
| migrate   | php artisan migrate                     |
| seed      | php artisan db:seed                     |

## Make a copy of .env and vhosts/default.conf
Run the Makefile command below to make a copy to .env file
```
make env
```

Change the environment variables

| Environment       | Description               |
|-------------------|:--------------------------|
| PROJECT_NAME      | Container name            |
| LARAVEL_VERSION   | Choose a Laravel version  |
| PHP_VERSION       | Select PHP version        |
| LOCAL_HTTP_PORT   | Change HTTP port          |
| LOCAL_HTTPS_PORT  | Change HTTPS port         |

## Setting up database
If using host machine database. Set the Laravel .env DB_HOST to use the internal host gateway
```
DB_HOST=host.docker.internal
```

If using Database image, make sure to uncomment the database section in:
- .env file
- docker-compose.yml file
- In Laravel .env file set the DB_HOST=localhost

## Build Docker image and make Laravel project
The command below will build the Docker container and setup a Laravel project
```
make project
```

## Open project in browser
To view the project, open a browser and enter in the container url.
```
http://localhost:8080
```

## Run migration and seeders with Makefile commands
```
# Run migrate
make migrate

# Run seeder
make seed
```

To execute a command inside the running container
```
make exec
```
