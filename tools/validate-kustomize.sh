# todo
#!/bin/bash
set -e

# Run kustomize build for all overlays
find applications -name kustomization.yaml | while read file; do
  dir=$(dirname "$file")
  echo "Validating Kustomize manifests in $dir"
  kustomize build "$dir" > /dev/null || { echo "Kustomize validation failed in $dir"; exit 1; }
done