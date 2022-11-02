# laravel-base on Apache

## Introduction

Build a simple laravel development environment with docker-compose.

## Usage

```bash
$ git clone https://github.com/Yamamoto0525/laravel-base
$ cd laravel-base
$ make init 
```

http://localhost

Read this [Makefile](https://github.com/Yamamoto0525/laravel-base/blob/main/Makefile).

## Container structure

```bash
├── web
├── db
└── pma
```

### web container

- Base image
  - [php & Apache](https://hub.docker.com/layers/php/library/php/8.0.3-apache-buster/images/sha256-1d949fde1481072fcc001f211b849cd1c44ba7250a7574c268541fab64128608?context=explore):8.0.3-apache-buster
  - [node](https://hub.docker.com/_/node):node:14-buster
  - [composer](https://hub.docker.com/_/composer):2.0

### db container

- Base image
  - [mysql](https://hub.docker.com/_/mysql):8.0

### pma container

- Base image
  - [phpmyadmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/):phpmyadmin/phpmyadmin

#### Persistent MySQL Storage

By default, the [named volume](https://docs.docker.com/compose/compose-file/#volumes) is mounted, so MySQL data remains even if the container is destroyed.
If you want to delete MySQL data intentionally, execute the following command.

```bash
$ make restart
```
