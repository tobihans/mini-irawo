# Irawo Mini

Ce projet est une assignation dans le cadre de mon interview à [IRAWO](https://www.irawo.co).
Il s'agit d'une reproduction simplifiée de la section *Resources*.

## Fonctionnalités 
- [x] Liste des ressources disponibles
- [x] Achat des ressources
- [x] Landing page de chaque ressource
- [x] Historique des ressources achetées
- [x] Authentification des utilisateurs
- [x] Espace administrateur :
  - [x] Ajout de ressource
  - [x] Édition de ressource
  - [x] Suppression de ressource
## Démo
Une version de démo de l'application est déployée à l'adresse [https://mini-irawo.tobihans.space](https://mini-irawo.tobihans.space).

**Identifiants**:
- Compte Admin: admin@mini-irawo.tobihans.space / `password`
- Compte Utilisateur: client@mini-irawo.tobihans.space / `password`

## Développement 
### Prérequis
Il s'agit d'un projet Ruby on Rails typique, il faudra donc:
- `ruby >= 3` 
- `sqlite3`, pour la base de données 

### Mise en place
Pour démarrer le projet, il faut:
- Installer les dépendances 
```sh
bundle install
```
- Démarrer les serveur de développement
```sh
bin/rails server # -b 0.0.0.0 # [LAN]
```
L'application sera accessible à l'adresse [http://localhost:3000](http://localhost:3000).

&copy; Copyright 2024 Hans Tognon
