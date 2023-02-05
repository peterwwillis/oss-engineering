#!/usr/bin/env sh
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd -P)" ; export PATH="$SCRIPTDIR:$PATH"

DEVSPACE_VERSION="latest"

# shellcheck disable=SC2034
export ALPINE_PKGS="bash \
    bind-tools \
    build-base \
    coreutils \
    curl \
    git \
    iputils \
    openssl \
    vim \
    wget"
# shellcheck disable=SC2034
export APK_PKGS="bash \
        coreutils \
        curl \
        dnsutils \
        git \
        inetutils-ping \
        openssl \
        vim \
        wget"
install_os_pkgs.sh


ARCH_SHORT="arm64"
ARCH=$(arch)
if [ "$ARCH" = "x86_64" ]; then
    ARCH_SHORT="amd64"
fi

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$ARCH_SHORT/kubectl"
chmod +x kubectl
install -p kubectl /usr/local/bin;
rm kubectl

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh
rm get_helm.sh

url="$(curl -fsSL "https://api.github.com/repos/loft-sh/devspace/releases/$DEVSPACE_VERSION" \
    | grep "browser_download_url.*devspace-linux-$ARCH_SHORT" \
    | cut -d : -f 2,3 \
    | tr -d '" ' \
    | grep -v '.sha256')"
curl -fsSL -o devspace "$url"

chmod +x devspace
install -p devspace /usr/local/bin;
rm devspace

devspace add plugin https://github.com/loft-sh/loft-devspace-plugin

url="$(curl -fsSL https://api.github.com/repos/loft-sh/loft/releases/latest \
    | grep "browser_download_url.*loft-linux-$ARCH_SHORT" \
    | cut -d : -f 2,3 \
    | tr -d '" ' \
    | grep -v '.sha256')"
curl -fsSL -o loft "$url"

chmod +x loft
install -p loft /usr/local/bin;
rm loft
