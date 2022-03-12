#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/GoogleContainerTools/skaffold"
DOWNLOAD_URL="https://storage.googleapis.com/skaffold/releases"
TOOL_NAME="skaffold"
TOOL_TEST="skaffold version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' | sed 's/2.2.3//'
}

list_all_versions() {
  list_github_tags
}

get_arch() {
  local arch=""

  case "$(uname -m)" in
  x86_64 | amd64) arch="amd64" ;;
  i686 | i386) arch="386" ;;
  armv6l | armv7l) arch="arm" ;;
  aarch64 | arm64) arch="arm64" ;;
  *)
    fail "Arch '$(uname -m)' not supported!"
    ;;
  esac

  echo -n $arch
}
# https://github.com/GoogleContainerTools/skaffold/releases/download/v1.28.0/skaffold-darwin-arm64
get_platform() {
  local platform=""

  case "$(uname | tr '[:upper:]' '[:lower:]')" in
  darwin) platform="darwin" ;;
  freebsd) platform="freebsd" ;;
  linux) platform="linux" ;;
  openbsd) platform="openbsd" ;;
  windows) platform="windows" ;;
  *)
    fail "Platform '$(uname -m)' not supported!"
    ;;
  esac

  echo -n $platform
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"
  url="$DOWNLOAD_URL/v${version}/skaffold-$(get_platform)-$(get_arch)"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
