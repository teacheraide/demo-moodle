#!/bin/bash
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

mkdir -p "/bitnami/moodle"

if [[ ! -f "/bitnami/moodle/.user_scripts_initialized" ]]; then
  touch "/bitnami/moodle/.user_scripts_initialized"
fi

# Only execute init scripts once and store the filename into /bitnami/moodle/.user_scripts_initialized
if [[ -d "/docker-entrypoint-init.d" ]]; then
  read -r -a init_scripts <<<"$(find "/docker-entrypoint-init.d" -type f -print0 | sort -z | xargs -0)"
  for init_script in "${init_scripts[@]}"; do
    if ! grep -q "$init_script" "/bitnami/moodle/.user_scripts_initialized"; then
      for init_script_type_handler in /post-init.d/*.sh; do
        "$init_script_type_handler" "$init_script"
      done
      echo "$init_script" >>"/bitnami/moodle/.user_scripts_initialized"
    fi
  done
fi
