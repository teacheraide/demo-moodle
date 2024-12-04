#!/bin/bash
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0
#
# Executes custom PHP init scripts

# shellcheck disable=SC1091

# duplicate the script to install new versions of the plugins

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries with logging functions
if [[ -f /opt/bitnami/base/functions ]]; then
  . /opt/bitnami/base/functions
else
  . /opt/bitnami/scripts/liblog.sh
fi

apt update
apt install -y curl

download_and_extract() {
  local url=$1
  local download_dir=$2
  local tarball_name=$(basename "$url")

  info "Downloading tarball from $url"
  mkdir -p "$download_dir"
  curl -L "$url" -o "$download_dir/$tarball_name"

  info "Extracting tarball"
  tar --strip-components=1 -xzvf "$download_dir/$tarball_name" -C "$download_dir"
  rm -f "$download_dir/$tarball_name"
}

local_teacheraide_release="v1.0.0"
tiny_teacheraide_release="v1.0.0"

info "Installing Teacheraide local plugin $local_teacheraide_release"

download_and_extract "https://github.com/teacheraide/moodle-local_teacheraide/archive/refs/tags/$local_teacheraide_release.tar.gz" "/bitnami/moodle/local/teacheraide"

info "Installing Teacheraide tiny plugin $tiny_teacheraide_release"

download_and_extract "https://github.com/teacheraide/moodle-tiny_teacheraide/archive/refs/tags/$tiny_teacheraide_release.tar.gz" "/bitnami/moodle/lib/editor/tiny/plugins/teacheraide"

info "Teacheraide plugins installed successfully"

apt remove -y curl
