# gitops-repo

This is a GitOps monorepo for ArgoCD running in a single management cluster.
 
## Structure

The idea is to have one folder (apps) where we specify custom applications developed by our dev teams. 
Another folder (infrastructure) is where DevOps engineers will work, deploying infrastructure and middleware to our clusters. Finally, we need a folder (argocd) to instruct the single ArgoCD about what to deploy and where.

To recap, we have three main folders:

- **apps**: Contains custom applications developed by the dev teams.
- **argocd**: Includes ArgoCD Application Custom Resources (CRs) to manage deployments.
- **infrastructure**: Houses all middleware and infrastructure deployed by the DevOps team.

[How to Structure your Gitops Repository with a Single ArgoCD Management Instance](https://medium.com/@paolocarta_it/how-to-structure-your-gitops-repository-with-a-single-argocd-instance-f128b916c915)

[My website](https://paolocarta.com)