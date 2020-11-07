NAME := docker-shadowsocks-libev
TAG := x86_64
DOCKER = docker
IMAGE_NAME := shugaoye/$(NAME)

.PHONY: help build push clean test

help: ## - Help
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | column -c2 -t -s :)\n"

build: ## - Builds docker image latest
	$(DOCKER) build --build-arg SS_VER=3.35 -t $(IMAGE_NAME):$(TAG) .

push: ## - Pushes the docker image to hub.docker.com
	# Don't --pull here, we don't want any last minute upsteam changes
	$(DOCKER) build --build-arg SS_VER=3.35 -t $(IMAGE_NAME):$(TAG) .
	#docker tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):latest
	$(DOCKER) push $(IMAGE_NAME):$(TAG)
	#docker push $(IMAGE_NAME):latest

clean: ## - Remove built images
	#docker rmi $(IMAGE_NAME):latest || true
	$(DOCKER) rmi $(IMAGE_NAME):$(TAG) || true

test: ## - Test image
	./run_image.sh $(IMAGE_NAME):$(TAG)

