#!/usr/bin/env bash
set -euo pipefail

export PATH="/run/current-system/sw/bin:$PATH"
export GIT_SSH="/run/current-system/sw/bin/ssh"

cd /home/server/nixosConfigs
git pull origin main
