include .env
laravel = ${LARAVEL_VERSION}

project:
	@make build
	@make up
	@make laravel
	@make composer-install
	@make npm-install

build: 
	cp docker/config/vhosts/default.example.conf docker/config/vhosts/default.conf
	docker compose build --no-cache --force-rm

up: 
	docker compose up -d

down: 
	docker compose down

exec: 
	docker exec -it ${PROJECT_NAME} /bin/bash

laravel:
ifeq ($(laravel),)
	docker exec ${PROJECT_NAME} bash -c "composer create-project laravel/laravel ."
else
	docker exec ${PROJECT_NAME} bash -c "composer create-project laravel/laravel=${laravel} ."
endif

composer-install:
	docker exec ${PROJECT_NAME} bash -c "composer install"

migrate:
	docker exec ${PROJECT_NAME} bash -c "php artisan migrate"

seed:
	docker exec ${PROJECT_NAME} bash -c "php artisan db:seed"

npm-dev:
	cd ./html; npm run dev

npm-build:
	cd ./html; npm run build

npm-install:
	cd ./html; npm install
	
permissions:
	docker exec ${PROJECT_NAME} bash -c "chmod -R 775 storage bootstrap/cache"
	docker exec ${PROJECT_NAME} bash -c "chown -R $$USER:www-data storage"
	docker exec ${PROJECT_NAME} bash -c "chown -R $$USER:www-data bootstrap/cache"
