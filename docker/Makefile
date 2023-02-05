
DOCKER_BUILD_SH := ./bin/build_docker_image.sh

all: shellcheck python deployment

shellcheck:
	make -C bin shellcheck

python:
	$(DOCKER_BUILD_SH) python

deployment:
	$(DOCKER_BUILD_SH) deployment
