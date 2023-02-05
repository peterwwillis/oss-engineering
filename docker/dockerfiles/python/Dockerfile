##### Base image default
ARG BASEIMG=python:3.10.9-alpine3.17

### Production image
##### Contains just the files needed to start the application in production
FROM ${BASEIMG} AS production

ARG DEBUG
ENV DEBUG=$DEBUG

# Force bash to load /etc/profile for all scripts, so we can resolve /etc/profile.d/asdf.sh
ENV BASH_ENV=/etc/profile

COPY bin/install_os_pkgs.sh bin/install_prod_tooling.sh /tmp/bin/
RUN /tmp/bin/install_prod_tooling.sh

COPY bin/entrypoint.sh /bin/
ENTRYPOINT /bin/entrypoint.sh

CMD bash -l

### Development image
##### Contains development tools installed on top of production image
FROM production AS development

ARG DEBUG
ENV DEBUG=$DEBUG

COPY bin/install_os_pkgs.sh bin/install_dev_tooling.sh /tmp/bin/
RUN /tmp/bin/install_dev_tooling.sh
