# Laravel with Docker
This is for Laravel local development with Docker Compose. This built consists of PHP (8.2, 8.1, 8.0, 7.4, 7.3, 7.2), Apache and MariaDB (10.6, 10.5, 10.4, 10.3). Set the version needed in .env file. 

You can have the project up and running in a few minutes.
- Clone this git repository and CD into the project diretory
- Type: `make env` and change the environment to your specification
- Type: `make project` to build the container and create Laravel project

And that's' it! Direct your browser to http://localhost

## Prerequistes:
- [Docker](https://www.docker.com/products/docker-desktop/)
- [Makefile](https://www.gnu.org/software/make/) | It's recommended to install Makefile, but if you prefer to install manually, look in the Makefile file for all the commands to get the project up and running.

## Installation
Clone this Git repository and rename your project to anything you want.
``` 
git clone https://github.com/siquang/laradocker.git laravel-app

cd laravel-app
```

## Make a copy of .env and vhosts/default.conf
Run the Makefile command below to make a copy to .env file
```
make env
```

Change the environment variables in .env file. If using PHP < 8.0 make sure to choose the correct Laravel version that support the PHP version you are using.

| Environment       | Description               |
|-------------------|:--------------------------|
| PROJECT_NAME      | Container name            |
| LARAVEL_VERSION   | Leave blank for latest    |
| PHP_VERSION       | Select PHP version        |
| LOCAL_HTTP_PORT   | Change HTTP port          |
| LOCAL_HTTPS_PORT  | Change HTTPS port         |

## Setting up database
If using host machine database. Set DB_HOST in Laravel .env to use the internal host gateway.
```
DB_HOST=host.docker.internal
```

If using Database image, make sure to uncomment the database section in:
- .env file
- docker-compose.yml file
- In Laravel .env file set the DB_HOST=localhost

## Create a Laravel project and build container
Type the command below to build the container, fire up the webserver and install Laravel project all in one command. All Laravel files will be install under the directory 'html'.
```
make project
```

OR if you prefer to do each step manually, here are the commands.
```
make build
make up
make laravel
make composer-update
```

## Open project in browser
To view the project, open a browser and enter in the container url.
```
http://localhost:8080
```

## Run migration and seeders with Makefile commands
You can use the `make migrate` or `make seed` to migrate and seed the database.
```
# Run migrate
make migrate

# Run seeder
make seed
```

To execute a command inside the running container.
```
make exec
```

---
> ### NOTE: Execute all Laravel `php artisan` commands inside the '*html*' directory and execute all Makefile commands inside project root directory where the Makefile is located.
---

## Makefile Commands
These are some of the Makefile commands to use with your development.

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
| npm-dev   | Run command: npm run dev                |
| npm-build | Run command: npm run build              |
