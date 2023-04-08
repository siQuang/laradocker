# Boilerplate for Laravel Development with Docker

## Prerequistes:
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) Installed
- Composer (globally install)
- Git
- npm

## Clone repo from Github to local directory
``` 
cd /User/username/Sites

git clone https://github.com/siquang/laradocker.git 

cd laradocker
```
## Rename .env.laradocker to .env and change the following variables
- COMPOSE_PROJECT_NAME | Change the container name
- PHPVERSION | Select PHP version
- LOCAL_HTTP_PORT | Change HTTP port
- LOCAL_HTTPS_PORT | Change HTTPS port

## Rename /vhosts/default.example.conf to /vhosts/default.conf
```
cd docker/bin/config/vhosts

cp default.example.conf default.conf
```

## Create new Laravel project
NOTES: Keep the project name 'html'. If you change the namemake sure to also change this in .env, docker-compose.yml, and Dockerfile
```
composer create-project lavarel/laravel html
```

## Or, create a new Laravel project by globally installing the Laravel installer via Composer
NOTES: Keep the project name 'html'. If you change the namemake sure to also change this in .env, docker-compose.yml, and Dockerfile
```
composer global require laravel/installer

laravel new html
```

## Run Artisan command
Run all artisan commands inside a running container shell
```
docker exec -it laradocker /bin/bash
```

# Laravel 10 + Inertia + ReacJS

## Install Inertia (Server-side)

Install Inertia server-side adapter using Composer package manager
```
cd src
composer require inertiajs/inertia-laravel
```

Copy the following code to the root template resources/views/app.blade.php 
```
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>

        @viteReactRefresh
        @vite(['resources/css/app.css', 'resources/js/app.jsx'])
        @inertiaHead
    </head>
    <body>
        @inertia
    </body>
</html>
```

Setup the Inertia middleware
```
php artisan inertia:middleware
```

Register the HandleInertiaRequests middleware in App\Http\Kernel as the last item in the web group
```
'web' => [
    // ...
    \App\Http\Middleware\HandleInertiaRequests::class,
],
```

Replace Laravel render with Inertia::render in controller
```
use Inertia\Inertia;

class EventsController extends Controller
{
    public function show(Event $event)
    {
        return Inertia::render('Event/Show', [
            'event' => $event->only(
                'id',
                'title',
                'start_date',
                'description'
            ),
        ]);
    }
}
```

## Install Inertia (Client-side) with ReactJS

Install dependencies with NPM
```
cd src
npm install @inertiajs/react @vitejs/plugin-react react react-dom
```

Update vite.config.js file and add reactjs plugin
```
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import react from '@vitejs/plugin-react';

export default defineConfig({
    plugins: [
        react(),
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
});
```

Initialize the Inertia app with base component, and rename the file app.js => app.jsx
```
import { createInertiaApp } from '@inertiajs/react'
import { createRoot } from 'react-dom/client'

createInertiaApp({
  resolve: name => {
    const pages = import.meta.glob('./Pages/**/*.jsx', { eager: true })
    return pages[`./Pages/${name}.jsx`]
  },
  setup({ el, App, props }) {
    createRoot(el).render(<App {...props} />)
  },
})
```

Add a new directory 'Pages' in resources/js/
```
cd src/resources/js
mkdir Pages
```

Create a new React page call Welcome.jsx in Pages directory and add some test
```
const Welcome = () => {
  return (
    <h1>Welcome to our new app</h1>
  )
}

export default Welcome;
```

Update render method in routes/web.php
```
use Inertia\Inertia;
...

Route::get('/', function () {
    return inertia::render('Welcome');
}
```

Remove the following unused Laravel files
```
src/resources/js/bootstrap.js
src/resources/views/welcome.blade.php
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
