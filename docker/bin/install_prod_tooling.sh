#!/usr/bin/env sh
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd -P)" ; export PATH="$SCRIPTDIR:$PATH"

# shellcheck disable=SC2034
export ALPINE_PKGS="bash \
        curl \
        git"
# shellcheck disable=SC2034
export APK_PKGS="bash \
        curl \
        git"
install_os_pkgs.sh

git clone https://github.com/asdf-vm/asdf.git /usr/share/asdf --branch v0.11.1
cat <<'EOSCRIPT' > /etc/profile.d/asdf.sh
#!/usr/bin/env sh
. "/usr/share/asdf/asdf.sh"
EOSCRIPT

