# DevOps - K8s-WebApp-Deployment
## Projet de Déploiement d'une Application Web avec Kubernetes et Terraform

Ce projet vise à fournir une solution complète pour le déploiement local d'une application web end-to-end via Kubernetes. L'objectif est d'automatiser entièrement le processus de déploiement en utilisant un script unique, incluant la création d'un équilibrage de charge, le déploiement de deux conteneurs d'application, et le déploiement d'un conteneur de base de données.

## Technologies utilisées

- **Docker:** Utilisé pour la conteneurisation de l'application et de la base de données.
- **Kubernetes (K8s):** Utilisé pour l'orchestration des conteneurs.
- **Vagrant:** Utilisé pour la gestion de Machines Virtuelles.

## Structure du Projet

```plaintext
/project
|-- /app
| |-- deployment.yaml
|-- /database
| |-- deployment.yaml
|-- Vagrantfile
|-- provisioning-script.sh
|-- deployment-script.sh
|-- README.md
```

- **/projet/app/deployment.yaml**: Configuration de déploiement pour l'application.
- **/projet/database/deployment.yaml**: Configuration de déploiement pour la base de données.

## Prérequis

Assurez-vous d'avoir les outils suivants installés sur votre machine de développement :
- Vagrant installé localement
- VirtualBox (ou autre fournisseur Vagrant) installé localement

## Instructions d'utilisation

1. Clonez ce dépôt sur votre machine local.
   ```bash
   git clone https://github.com/votre-utilisateur/nom-du-projet.git
2. Naviguez vers le dossier du projet.
   ```bash
   cd nom-du-projet
3. Lancez la machine virtuelle Vagrant.
   ```bash
   vagrant up
4. Une fois la VM démarrée, provisionnez-la avec les dépendances nécessaires.
   ```bash
   vagrant provision
5. Exécutez le script de déploiement à l'intérieur de la VM.
   ```bash
   vagrant ssh -c "/chemin/vers/deployment-script.sh"
