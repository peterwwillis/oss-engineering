#!/usr/bin/env bash
# NOTE: must use bash in order to load asdf
set -eu
[ "${DEBUG:-0}" = "1" ] && set -x

echo "Installing extra OS tools..."
# gpg and gpg-agent are needed to validate signatures
# coreutils is needed for 'sort' as some asdf plugins use its non-standard options
export ALPINE_PKGS="gpg gpg-agent coreutils"
export APK_PKGS="gpg gpg-agent coreutils"
/tmp/bin/install_os_pkgs.sh

echo "Installing asdf plugins..."

grep -v '^#|^[[:space:]]*$' tool-versions.txt | while read -r name version url ; do
    [ -n "${name:-}" -a -n "${version:-}" -a -n "${url:-}" ] || continue
    echo "name '$name' version '$version' url '$url'"
    asdf plugin add "$name" "$url"
    asdf install "$name" "$version"
done
