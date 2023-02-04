
DOCKER_BUILD_SH := ./bin/make_docker_image.sh

all: shellcheck python

shellcheck:
	make -C bin shellcheck

python:
	$(DOCKER_BUILD_SH) python
