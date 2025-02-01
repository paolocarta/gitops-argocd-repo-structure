#!/bin/bash

set -e  # Exit on error
set -o pipefail

NAMESPACE="argocd"
VERSION=v2.13.4
ARGOCD_PATH="infrastructure/argocd"
ROOT_APP_PATH="argocd/bootstrap/root-app.yaml"
 
CLUSTERS=("dev" "prod") # assume we have the context setup in the kubeconfig

for CLUSTER in "${CLUSTERS[@]}"; do
    kubectl config use-context $CLUSTER

    echo "Creating namespace: $NAMESPACE in cluster: $CLUSTER"
    kubectl create namespace $NAMESPACE || echo "Namespace $NAMESPACE already exists in cluster: $CLUSTER"

    echo "Installing ArgoCD in cluster: $CLUSTER..."
    kubectl apply -n $NAMESPACE -f $ARGOCD_PATH

    echo "Waiting for ArgoCD server to be ready in cluster: $CLUSTER..."
    kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n $NAMESPACE

    # echo "Retrieving ArgoCD initial admin password in cluster: $CLUSTER..."
    # kubectl -n $NAMESPACE get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    # echo -e "\nUse the above password to log in to ArgoCD."

    echo "Applying root-app.yaml to let ArgoCD manage itself in cluster: $CLUSTER..."
    sed -i.bak "s/env/$CLUSTER/g" $ROOT_APP_PATH
    kubectl apply -f $ROOT_APP_PATH -n $NAMESPACE

    # echo "Bootstrap complete! Access ArgoCD UI in cluster: $CLUSTER:"
    # echo "kubectl port-forward svc/argocd-server -n $NAMESPACE 8080:443"
done
