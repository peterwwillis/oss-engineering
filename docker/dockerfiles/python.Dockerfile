##### Base image default
ARG BASEIMG=python:3.10.9-alpine3.17

### Production image
##### Contains just the files needed to start the application in production
FROM ${BASEIMG} AS production

ARG DEBUG
ENV DEBUG=$DEBUG

COPY bin/install_prod_tooling.sh /tmp
RUN /tmp/install_prod_tooling.sh

### Development image
##### Contains development tools installed on top of production image
FROM production AS development

ARG DEBUG
ENV DEBUG=$DEBUG

COPY bin/install_dev_tooling.sh /tmp
RUN /tmp/install_dev_tooling.sh

