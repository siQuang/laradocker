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

## Install Inertia (Client-side) for ReactJS

Install dependencies with NPM
```
cd src
npm install @inertiajs/react @vitejs/plugin-react react react-dom
```

Initialize the Inertia app with base component
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
