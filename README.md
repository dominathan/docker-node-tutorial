# Docker / Docker-Compose Toots

## What is Docker?

- Open source containerization platform. Package app code with OS libraries and dependencies to run in any environment

## Why Docker?

1. Portability (but it works on my machine!)
1. Microservice Architecture (and even monoliths with many dependencies)
1. Better CI/CD

## What is Docker Compose

- Running many containers at once (local container orchestration)

## Why is Docker Compose

1. Better DX!

## Docker Commands

- `docker ps` - see all running docker processes
- `docker build -t docker-toots:0.0.1 .` build an image from a docker file
- `docker run --rm -d --name docker-toots -p 3000:3000 docker-toots:0.0.1` - run a detatched container
- `docker exec -it docker-toots /bin/sh` - connect to running containers shell
- `docker-compose run --rm docker-toots` - start a new container and container to it via shell (if dockerfile entrypoint is /bin/sh)

## Docker-Compose Commands

- `docker-compose build --parallel` - build all containers in your dockerfile
- `docker-compose up` - start all containers, add `-d` if you want to keep start process in background
- `docker-compose logs -f --tail=${2:-500} CONTAINER_NAME` - show logs (limit scope)

## Getting Started

`cp .env.sample .env`

If not using docker, make sure mongo is running
`npm install`
`npm run dev`

If using docker-compose

`docker-compose up`
