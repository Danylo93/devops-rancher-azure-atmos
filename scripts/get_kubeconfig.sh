#!/usr/bin/env bash
set -euo pipefail
RG="$1"; AKS="$2"
az aks get-credentials -g "$RG" -n "$AKS" --overwrite-existing
kubectl get nodes -o wide