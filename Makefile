# #################
# Variables
# #################
.DEFAULT_GOAL := help
COMPOSE_PROJECT_NAME = php-ddd-service-template
DOCKER_COMPOSE = docker-compose -f ./docker/docker-compose.yml
DOCKER_COMPOSE_PHP_FPM_EXEC = ${DOCKER_COMPOSE} exec -u www-data ${COMPOSE_PROJECT_NAME}_php-fpm
DOCKER_COMPOSE_DB_EXEC = docker exec -it ${COMPOSE_PROJECT_NAME}_database

# #################
# Docker compose
# #################

build: ##- Build the project
	${DOCKER_COMPOSE} build

start: ##- Start the project
	${DOCKER_COMPOSE} start

stop:  ##- Stop the project
	${DOCKER_COMPOSE} stop

up: ##- Start the project removing the orphan items
	${DOCKER_COMPOSE} up -d --remove-orphans

ps:  ##- Show all the running services
	${DOCKER_COMPOSE} ps

logs: ##- Show the docker log
	${DOCKER_COMPOSE} logs -f

down: ##- Shutdown the project removing it
	${DOCKER_COMPOSE} down -v --rmi=all --remove-orphans


# #################
# App
# #################

help: ## Show this help.
	@fgrep -h "##-" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##-//'

sh: ##- Connect to the php-fpm container
	${DOCKER_COMPOSE} exec -u www-data ${COMPOSE_PROJECT_NAME}_php-fpm bash

db: ##- Connect to the database container
	${DOCKER_COMPOSE_DB_EXEC} bash

.PHONY: tests
tests: ##- Run the app tests
	@docker exec -u www-data --tty -e APP_ENV=test ${COMPOSE_PROJECT_NAME}_php-fpm php bin/console doctrine:database:drop --if-exists --force
	@docker exec -u www-data --tty -e APP_ENV=test ${COMPOSE_PROJECT_NAME}_php-fpm php bin/console doctrine:database:create --if-not-exists --no-interaction
	@docker exec -u www-data --tty -e APP_ENV=test ${COMPOSE_PROJECT_NAME}_php-fpm php bin/console doctrine:migrations:migrate --no-interaction
	@docker exec -u www-data --tty -e APP_ENV=test ${COMPOSE_PROJECT_NAME}_php-fpm ./bin/phpunit $(TESTS_PATH) $(TESTS_SUITE) $(TEST_FILE)


# #################
# Database
# #################

db_migrate:  ##- Run migrations
	${DOCKER_COMPOSE} exec -u www-data ${COMPOSE_PROJECT_NAME}_php-fpm bin/console doctrine:migrations:migrate --no-interaction
db_diff: ##- Show migrations diff
	${DOCKER_COMPOSE} exec -u www-data ${COMPOSE_PROJECT_NAME}_php-fpm bin/console doctrine:migrations:diff --no-interaction

# #################
# Static code analysis
# #################

phpstan: ##- Run phpstan
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/phpstan analyse src tests -c phpstan.neon

deptrac: ##- Run php deptrac
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/deptrac analyze deptrac-layers.yaml
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/deptrac analyze deptrac-modules.yaml

cs-fix: ##- Run php cs-fixer
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/php-cs-fixer fix

cs-fix-diff: ##- Run php cs-fixer preview
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/php-cs-fixer fix --dry-run --diff