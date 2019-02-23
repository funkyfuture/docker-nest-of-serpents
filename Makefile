.DEFAULT_GOAL := build

BASEIMAGE="$(shell head -n 1 Dockerfile | cut -f 2 -d ' ')"
IMAGE=funkyfuture/nest-of-serpents

.PHONY: build
build: pull-base
	docker build -t $(IMAGE) .

.PHONY: pull-base
pull-base:
	docker pull $(BASEIMAGE)

.PHONY: run
run: build
	docker run --rm -ti $(IMAGE)
