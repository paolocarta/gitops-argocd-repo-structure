#!/bin/bash

set -e  # Exit on error
set -o pipefail

NAMESPACE="argocd"
VERSION=v2.13.4
ARGOCD_PATH="infrastructure/argocd"
ROOT_APP_PATH="argocd/bootstrap/root-app.yaml"

echo "Creating namespace: $NAMESPACE"
kubectl create namespace $NAMESPACE || echo "Namespace $NAMESPACE already exists"

echo "Installing ArgoCD..."
kubectl apply -n $NAMESPACE -f $ARGOCD_PATH

echo "Waiting for ArgoCD server to be ready..."
kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n $NAMESPACE

echo "Retrieving ArgoCD initial admin password..."
kubectl -n $NAMESPACE get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo -e "\nUse the above password to log in to ArgoCD."

echo "Applying root-app.yaml to let ArgoCD manage itself..."
kubectl apply -f $ROOT_APP_PATH -n $NAMESPACE

echo "Bootstrap complete! Access ArgoCD UI:"
echo "kubectl port-forward svc/argocd-server -n $NAMESPACE 8080:443"