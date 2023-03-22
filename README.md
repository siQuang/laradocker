# Setup Local (MacOS) Laravel Development with Docker

## Prerequistes:
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) Installed
- Composer (globally install)

## Clone repo from Github to local directory
``` 
cd /User/username/Sites

git clone https://github.com/siquang/laradocker.git 

cd laradocker
```
## Edit Docker .env file
- COMPOSE_PROJECT_NAME | Change the container name
- PHPVERSION | Select PHP version
- LOCAL_HTTP_PORT | Change HTTP port
- LOCAL_HTTPS_PORT | Change HTTPS port

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

# Bundling Assets with Vite and TailwindCSS

## Install Tailwind
```
cd src

npm install -D tailwindcss postcss autoprefixer

npx tailwindcss init -p
```

## Configure template paths in tailwind.config.js file
```
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

## Add the Tailwind directives to app.css
```
@tailwind base;
@tailwind components;
@tailwind utilities;
```