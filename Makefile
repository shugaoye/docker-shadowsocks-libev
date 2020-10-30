DOCKER = docker
IMAGE = shugaoye/ss-libev:latest
VOL1 ?= $(HOME)/vol1
VOL2 ?= $(HOME)/.ccache

dev: Dockerfile
	$(DOCKER) build --build-arg SS_VER=3.35 -t $(IMAGE) .

test:
	./run_image.sh $(IMAGE)

all: dev

.PHONY: all
