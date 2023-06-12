include .env
laravel = ${LARAVEL_VERSION}

project:
	@make cp.vhost
	@make docker.build
	@make docker.up
	@make laravel
	@make composer.install
	@make npm.install

docker.build: 
	docker compose build --no-cache --force-rm

docker.up: 
	docker compose up -d

docker.down: 
	docker compose down

docker.exec: 
	docker exec -it ${PROJECT_NAME} /bin/bash

cp.vhost:
	cp docker/config/vhosts/default.example.conf docker/config/vhosts/default.conf

laravel:
ifeq ($(laravel),)
	docker exec ${PROJECT_NAME} bash -c "composer create-project laravel/laravel ."
else
	docker exec ${PROJECT_NAME} bash -c "composer create-project laravel/laravel=${laravel} ."
endif

composer.install:
	docker exec ${PROJECT_NAME} bash -c "composer install"

npm.dev:
	cd ./html; npm run dev

npm.build:
	cd ./html; npm run build

npm.install:
	cd ./html; npm install
	
permissions:
	docker exec ${PROJECT_NAME} bash -c "chmod -R 775 storage bootstrap/cache"
	docker exec ${PROJECT_NAME} bash -c "chown -R $$USER:www-data storage"
	docker exec ${PROJECT_NAME} bash -c "chown -R $$USER:www-data bootstrap/cache"

laravel.version:
	docker exec ${PROJECT_NAME} bash -c "php artisan --version"

artisan.migrate:
	docker exec ${PROJECT_NAME} bash -c "php artisan migrate"

artisan.migrate.fresh:
	docker exec ${PROJECT_NAME} bash -c "php artisan migrate:fresh"

artisan.seed:
	docker exec ${PROJECT_NAME} bash -c "php artisan db:seed"

artisan.serve:
	docker exec ${PROJECT_NAME} bash -c "php artisan serve"

artisan.up:
	docker exec ${PROJECT_NAME} bash -c "php artisan up"

artisan.down:
	docker exec ${PROJECT_NAME} bash -c "php artisan down"

artisan.test:
	docker exec ${PROJECT_NAME} bash -c "php artisan test"

artisan.cache.clear:
	docker exec ${PROJECT_NAME} bash -c "php artisan cache:clear"

artisan.config.clear:
	docker exec ${PROJECT_NAME} bash -c "php artisan config:clear"

artisan.view.clear:
	docker exec ${PROJECT_NAME} bash -c "php artisan view:clear"