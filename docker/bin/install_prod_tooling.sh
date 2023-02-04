#!/usr/bin/env sh
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x

### Alpine linux
if command -v apk ; then

    apk add -U --no-cache \
        curl \
        git

### Debian / Ubuntu
elif command -v apt-get ; then

    export DEBIAN_FRONTEND="noninteractive"
    apt-get update \
    && apt-get install -y \
        curl \
        git \
    && rm -rf /var/lib/apt/lists/*

else
    echo "$0: ERROR: Could not detect package manager"
    exit 1
fi

git clone https://github.com/asdf-vm/asdf.git /usr/share/asdf --branch v0.11.1
cat <<'EOSCRIPT' > /etc/profile.d/asdf.sh
#!/usr/bin/env sh
. "/usr/share/asdf/asdf.sh"
EOSCRIPT

