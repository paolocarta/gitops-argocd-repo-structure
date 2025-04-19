# gitops-repo

This is a GitOps monorepo for ArgoCD running in a single management cluster.
 
## Structure

The idea is to have one folder (apps) where we specify custom applications developed by our dev teams. 
Another folder (infrastructure) is where DevOps engineers will work, deploying infrastructure and middleware to our clusters. Finally, we need a folder (argocd) to instruct the single ArgoCD about what to deploy and where.

To recap, we have 3 main folders:

- apps (Custom apps developed)
- argocd (argocd Application Custom Resources)
- infrastructure (All middleware deployed by Ops)

