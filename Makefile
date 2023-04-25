include .env

project:
	@make build
	@make up
	@make laravel
	@make composer-update
build: 
	docker compose build --no-cache --force-rm
up: 
	docker compose up -d
down: 
	docker compose down
exec: 
	docker exec -it ${PROJECT_NAME} /bin/bash
laravel:
	docker exec ${PROJECT_NAME} bash -c "composer create-project laravel/laravel=${LARAVEL_VERSION} ."
composer-update:
	docker exec ${PROJECT_NAME} bash -c "composer update"
env:
	cp .env.laradocker .env
	cp docker/config/vhosts/default.example.conf docker/config/vhosts/default.conf
migrate:
	docker exec ${PROJECT_NAME} bash -c "php artisan migrate"
seed:
	docker exec ${PROJECT_NAME} bash -c "php artisan db:seed"