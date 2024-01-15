# DevOps - K8s-WebApp-Deployment
# Projet de Déploiement d'une Application Web avec Kubernetes et Terraform

Ce projet vise à automatiser le déploiement d'une application web à l'aide de Kubernetes et Terraform. L'objectif est de créer une infrastructure cloud, provisionner un cluster Kubernetes, puis déployer une application web à l'intérieur de ce cluster.

## Technologies utilisées

- **Docker:** Utilisé pour la conteneurisation de l'application et de la base de données.
- **Kubernetes (K8s):** Utilisé pour l'orchestration des conteneurs.
- **Terraform:** Utilisé pour la provision de l'infrastructure Azure.
- **Azure CLI:** Utilisé pour la gestion des ressources Azure.
- **kubectl:** Utilisé pour interagir avec le cluster Kubernetes.

## Structure du Projet

```plaintext
project/
|-- terraform/
|   |-- main.tf
|   |-- variables.tf
|   |-- outputs.tf
|-- k8s/
|   |-- deployment.yaml
|   |-- service.yaml
|-- scripts/
|   |-- deploy.sh
```

- **terraform/:** Contient les fichiers de configuration Terraform pour provisionner l'infrastructure Azure.
- **k8s/:** Contient les fichiers de configuration YAML Kubernetes pour le déploiement de l'application.
- **scripts/:** Contient le script deploy.sh qui orchestre le déploiement en utilisant Terraform, Azure CLI, et kubectl.

## Prérequis

Assurez-vous d'avoir les outils suivants installés sur votre machine de développement :
- Docker
- Azure CLI
- kubectl
- Terraform

## Instructions d'utilisation

1. Clonez le projet sur votre machine locale.
2. Assurez-vous d'avoir les prérequis installés.
3. Configurez les variables nécessaires dans les fichiers Terraform.
4. Exécutez le script deploy.sh pour provisionner l'infrastructure, configurer kubectl, et déployer l'application.

```bash
./scripts/deploy.sh
```
## Avertissement
- Assurez-vous de gérer les informations sensibles de manière appropriée, en utilisant par exemple des fichiers de configuration non versionnés pour les secrets.
- Ce projet suppose une infrastructure Azure. Si vous utilisez un autre fournisseur cloud, vous devrez adapter les fichiers Terraform en conséquence.
