# laravel-base

## Introduction

Build a simple laravel development environment with docker-compose.

## Usage

```bash
$ git clone https://github.com/Yamamoto0525/laravel-base
$ cd laravel-base
$ make create-project # Install the latest Laravel project
$ make install-recommend-packages # Not required
```

http://127.0.0.1

Read this [Makefile](https://github.com/Yamamoto0525/laravel-base/blob/apache/Makefile).

## Container structure

```bash
├── web
└── db
```

### app container

- Base image
  - [php](https://hub.docker.com/_/php):8.0.3-apache-buster
  - [composer](https://hub.docker.com/_/composer):2.0

### db container

- Base image
  - [mysql](https://hub.docker.com/_/mysql):8.0

#### Persistent MySQL Storage

By default, the [named volume](https://docs.docker.com/compose/compose-file/#volumes) is mounted, so MySQL data remains even if the container is destroyed.
If you want to delete MySQL data intentionally, execute the following command.

```bash
$ make restart
```