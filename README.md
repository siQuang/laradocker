# Laravel - Docker - Makefile
This is for Laravel local development with Docker Compose. This built consists of PHP (8.2, 8.1, 8.0, 7.4, 7.3, 7.2), Apache and MariaDB (10.6, 10.5, 10.4, 10.3). Set the version needed in .env file. 

You can have the project up and running in a few steps.
- Clone this git repository and CD into the project diretory
- Make a copy of .env from .env.laradocker file
- Make changes in .env to your specification
- Type: `make project` to build the container and create Laravel project

And that's' it! Direct your browser to http://localhost:[ASSIGNED-PORT]

## Prerequistes:
- [Docker](https://www.docker.com/products/docker-desktop/)
- [Makefile](https://www.gnu.org/software/make/) | It's recommended to install Makefile, but if you prefer to install manually, look in the Makefile  for all the commands to get the project up and running.

## Installation
Clone this Git repository and rename your project to anything you want.
``` 
git clone https://github.com/siquang/laradocker.git laravel-app

cd laravel-app
```

## Make a copy of .env and make changes
Make sure to change the environment variables to your specification
```
cp .env.laradocker .env
```

Change the environment variables in .env file. If using PHP < 8.0 make sure to choose the correct Laravel version that support the PHP version you are using.

| Environment       | Description               |
|:------------------|:--------------------------|
| PROJECT_NAME      | Container name            |
| LARAVEL_VERSION   | Leave blank for latest    |
| PHP_VERSION       | Select PHP version        |
| LOCAL_HTTP_PORT   | Change HTTP port          |
| LOCAL_HTTPS_PORT  | Change HTTPS port         |

## Create a Laravel project and build container
Type the command below to build the Docker container, fire up the webserver and install Laravel project all in one command. All Laravel files will be install under the directory 'html'.
```
make project
```

OR if you prefer to do each step manually, here are the commands.
```
make cp.vhost
make docker.build
make docker.up
make laravel
make composer.install
make npm.install
```

## Open project in browser
To view the project, open a browser and enter in the container url.
```
http://localhost:[ASSIGNED-PORT]
```

## Run migration and seeders with Makefile commands
You can use the `make artisan.migrate` or `make artisan.seed` to migrate and seed the database.
```
# Run migrate
make artisan.migrate

# Run seeder
make artisan.seed
```

To execute a command inside the running container.
```
make docker.exec
```

---
> ### NOTE: Execute all Laravel `php artisan` commands inside the '*html*' directory and execute all Makefile commands inside project root directory where the Makefile is located.
---

## Makefile Commands
These are some of the Makefile commands to use with development.

Usage: **make COMMAND**

| Command               | Description                                               |
| ----------------------| :---------------------------------------------------------|
| project               | Build Docker and create Laravel project                   |
| docker.build          | Build Docker container                                    |
| docker.up             | Bring up Docker container                                 |
| docker.down           | Bring down Docker container                               |
| docker.exec           | Execute a command inside container                        |
| npm.dev               | Run Vite command: 'npm run dev' for Vite                  |
| npm.build             | Run Vite command: 'npm run build' for Vite                |
| npm.install           | Run command: 'npm install' inside Laravel app             |
| permissions           | Fix storage permissions                                   |
| laravel.version       | Check Laravel version                                     |
| artisan.migrate       | Run database migration                                    |
| artisan.migrate.fresh | Reset and re-run all migrations                           |
| artisan.seed          | Run Laravel command: 'php artisan db:seed'                |
| artisan.serve         | Run the Laravel application using PHP development server  |
| artisan.up            | Bring the application out of maintenance / demo mode      |
| artisan.down          | Put the application in maintenance / demo mode            |
| artisan.test          | Run the application tests                                 |
| artisan.cache.clear   | Clear application cache                                   |
| artisan.config.clear  | Clear application config                                  |
| artisan.view.clear    | Clear application views                                   |


## Setting up database
If using host machine database. In Laravel app .env file, use the internal host gateway.
```
DB_HOST=host.docker.internal
```

If using Database image, make sure to uncomment the database section in:
- .env file
- docker-compose.yml file
- In Laravel .env file set the DB_HOST=localhost
