.PHONY: build up down restart logs shell update clean

build:
	podman compose build

up:
	podman compose up

down:
	podman compose down

restart:
	podman compose restart

logs:
	podman compose logs -f

shell:
	podman compose run --rm jekyll bash

update:
	podman compose run --rm jekyll bundle update

clean:
	podman compose down --rmi all --volumes
