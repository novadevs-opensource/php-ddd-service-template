# PHP ddd service template

### Setup

To start locally this project using Docker you need to do the following steps:

1. Create the Docker configuration file `docker/.env` using the template `docker/.env.dist` and set there the values of the project like `COMPOSE_PROJECT_NAME`:

    ```
    cp -v docker/.env.dist docker/.env
    ```

    **NOTE:** If you change the default value of `COMPOSE_PROJECT_NAME` variable you will need to change it in the configuration file `Makefile` as well.

2. Ensure that the content of the `DATABASE_URL` variable in the configuration file `.env.dist` located in the project root directory has the same database values as the configuration file `docker/.env.dist`.

3. Start the project:

    ```
    make up
    ```

### Dockerise Symfony Application

- [X] [Install Docker](https://docs.docker.com/engine/install/)
- [X] [Install Docker Compose](https://docs.docker.com/compose/install/)
- [X] [Docker PHP & Nginx]()
- [X] [Create Symfony Application](https://symfony.com/doc/current/setup.html)

### Debugging

- [X] [Install Xdebug](https://xdebug.org/docs/install#pecl)
- [X] [Configure Xdebug in PhpStorm](https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html)

### Testing

- [X] [Install PHPUnit](https://symfony.com/doc/current/testing.html#the-phpunit-testing-framework)
- [X] [Integrate PHPUnit with a PhpStorm project](https://symfony.com/doc/current/testing.html#the-phpunit-testing-framework)

### Clean Architecture

- [X] [Onion Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [X] [Monolith First](https://martinfowler.com/bliki/MonolithFirst.html)

### Databases and the Doctrine ORM

- This project template has compatibility with both  MySQL and PostgreSQL
- [X] [Installing Doctrine](https://symfony.com/doc/current/doctrine.html)
- [X] [Setting up a Database](https://symfony.com/doc/current/the-fast-track/en/7-database.html)
- [X] [Mapping](https://www.doctrine-project.org/projects/doctrine-orm/en/current/reference/xml-mapping.html)
- [X] [Migrations](https://symfony.com/doc/current/doctrine.html#migrations-creating-the-database-tables-schema)
- [X] [Repository](https://symfony.com/doc/current/doctrine.html#querying-for-objects-the-repository)
- [X] [Database Testing](https://symfony.com/doc/current/testing/database.html)
- [X] [Fixtures](https://symfony.com/bundles/DoctrineFixturesBundle/current/index.html)

### CQRS

- [X] [CQRS pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/cqrs)
- [X] [Symfony Messenger](https://symfony.com/doc/current/messenger.html)

### Auth
- [X] [JWT Authentication](https://github.com/lexik/LexikJWTAuthenticationBundle)
- [X] [JWT Refresh Token](https://github.com/markitosgv/JWTRefreshTokenBundle)

### Static analysis tool
- [X] [PHP CS Fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer)
- [X] [Deptrac](https://qossmic.github.io/deptrac/)
- [X] [PHPStan](https://github.com/phpstan/phpstan)