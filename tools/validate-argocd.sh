#!/bin/bash
set -e

# Validate ArgoCD Application manifests
find argocd/applications -name '*.yaml' | while read file; do
  echo "Validating ArgoCD manifest: $file"
  yq eval . "$file" > /dev/null || { echo "Invalid YAML in $file"; exit 1; }
done