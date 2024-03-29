up:
	docker-compose up -d
	docker-compose exec web composer dump-autoload
build:
	docker-compose build --no-cache --force-rm
start:
	@make build
	@make up
	@make npm-dev
laravel-install:
	docker-compose exec web composer create-project --prefer-dist laravel/laravel .
create-project:
	@make build
	@make up
	@make laravel-install
	docker-compose exec web php artisan key:generate
	docker-compose exec web php artisan storage:link
	docker-compose exec web chmod -R 777 storage bootstrap/cache
	@make fresh
install-recommend-packages:
	docker-compose exec web composer require doctrine/dbal
	docker-compose exec web composer require --dev barryvdh/laravel-ide-helper
	docker-compose exec web composer require --dev beyondcode/laravel-dump-server
	docker-compose exec web composer require --dev barryvdh/laravel-debugbar
	docker-compose exec web composer require --dev roave/security-advisories:dev-master
	docker-compose exec web php artisan vendor:publish --provider="BeyondCode\DumpServer\DumpServerServiceProvider"
	docker-compose exec web php artisan vendor:publish --provider="Barryvdh\Debugbar\ServiceProvider"
init:
	docker-compose up -d --build
	docker-compose exec web composer install
	docker-compose exec web cp .env.local .env
	docker-compose exec web php artisan key:generate
	docker-compose exec web php artisan storage:link
	@make fresh
	@make npm-install
remake:
	@make destroy
	@make init
stop:
	docker-compose stop
down:
	docker-compose down --remove-orphans
restart:
	@make down
	@make up
	@make npm-dev
destroy:
	docker-compose down --rmi all --volumes --remove-orphans
destroy-volumes:
	docker-compose down --volumes --remove-orphans
ps:
	docker-compose ps
logs:
	docker-compose logs
logs-watch:
	docker-compose logs --follow
log-web:
	docker-compose logs web
log-web-watch:
	docker-compose logs --follow web
log-app:
	docker-compose logs app
log-app-watch:
	docker-compose logs --follow app
log-db:
	docker-compose logs db
log-db-watch:
	docker-compose logs --follow db
web:
	docker-compose exec web ash
migrate:
	docker-compose exec web php artisan migrate
fresh:
	docker-compose exec web php artisan migrate:fresh --seed
seed:
	docker-compose exec web php artisan db:seed ${CMD}
dacapo:
	docker-compose exec web php artisan dacapo
rollback-test:
	docker-compose exec web php artisan migrate:fresh
	docker-compose exec web php artisan migrate:refresh
tinker:
	docker-compose exec web php artisan tinker
test:
	docker-compose exec web php artisan test
optimize:
	docker-compose exec web php artisan optimize
optimize-clear:
	docker-compose exec web php artisan optimize:clear
cache:
	docker-compose exec web composer dump-autoload -o
	@make optimize
	docker-compose exec web php artisan event:cache
	docker-compose exec web php artisan view:cache
cache-clear:
	docker-compose exec web composer clear-cache
	@make optimize-clear
	docker-compose exec web php artisan event:clear
serve:
	docker-compose exec web php artisan serve --host 0.0.0.0
run:
	docker-compose exec web php artisan ${CMD}
db:
	docker-compose exec db bash
sql:
	docker-compose exec db bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
redis:
	docker-compose exec redis redis-cli
ide-helper:
	docker-compose exec web php artisan clear-compiled
	docker-compose exec web php artisan ide-helper:generate
	docker-compose exec web php artisan ide-helper:meta
	docker-compose exec web php artisan ide-helper:models --nowrite
npm:
	@make npm-install
npm-install:
	docker-compose exec web npm install
npm-dev:
	docker-compose exec web npm run dev
npm-watch:
	docker-compose exec web npm run watch
npm-watch-poll:
	docker-compose exec web npm run watch-poll
npm-hot:
	docker-compose exec web npm run hot
