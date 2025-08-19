#!/usr/bin/env bash
set -euo pipefail
az login --use-device-code
SUB="$1"
az account set --subscription "$SUB"
az account show -o table