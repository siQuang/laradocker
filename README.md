# Laravel with Docker

## Prerequistes:
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) Installed
- Composer (globally install)
- Git
- Node.js
- Makefile

## Clone repo from Github to local directory
``` 
cd /User/username/Sites

git clone https://github.com/siquang/laradocker.git laravel-app

cd laravel-app
```

## Makefile Commands
For more commands look in Makefile file

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
| PHPVERSION        | Select PHP version        |
| LOCAL_HTTP_PORT   | Change HTTP port          |
| LOCAL_HTTPS_PORT  | Change HTTPS port         |

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
