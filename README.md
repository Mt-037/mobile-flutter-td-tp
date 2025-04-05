📚 Travaux Pratiques 1 : Développement Full-Stack
🎯 Objectifs Pédagogiques
Ce TP vise à maîtriser trois compétences clés du développement moderne :

Programmation asynchrone avec Dart (Future, async/await)

Création d'API REST avec Node.js/Express

Intégration frontend/backend via des requêtes HTTP

📋 Mission Principale
Développer un système complet de gestion de produits et commandes comprenant :

Backend : API REST avec persistance JSON

Client : Application Dart consommant l'API

Tests : Validation avec Postman

🛠 Stack Technologique
Composant	Technologies
Backend	Node.js, Express, REST
Client	Dart, http package
Tests	Postman

📁 Architecture Complète du Projet

TP1/
├── api_client/          # Client Dart (Frontend)
│   ├── bin/             # Exécutables
│   │   └── api_client.dart
│   ├── lib/             # Code source principal
│   │   └── api_client.dart
│   ├── test/            # Tests unitaires
│   │   └── api_client_test.dart
│   ├── commande.dart    # Modèle de commande
│   ├── produit.dart     # Modèle de produit
│   ├── main.dart        # Point d'entrée
│   ├── pubspec.yaml     # Dépendances Dart
│   └── pubspec.lock
│
├── tp-backend/          # API Node.js (Backend)
│   ├── node_modules/    # Dépendances npm
│   ├── data.json        # Base de données
│   ├── server.js        # Serveur Express
│   ├── package.json     # Configuration projet
│   └── package-lock.json
│
└── screens/             # Captures d'écran & UI
    ├── Get orders.PNG   # Preuve de test API
    ├── Get products.PNG
    ├── Screen 1.PNG     # Interfaces utilisateur
    ├── commande créée.PNG
    └── produit ajoute.PNG
    
🔍 Explications par Dossier :
1. api_client/ (Frontend Dart)
bin/ : Contient le point d'entrée de l'application

lib/ : Logique métier et services API

Modèles :

commande.dart : Structure des commandes

produit.dart : Structure des produits

Tests : Validation des composants

2. tp-backend/ (Backend Node.js)
server.js : Configuration du serveur Express

data.json : Persistance des données (remplace une base de données)

package.json : Dépendances et scripts npm

3. screens/ (Preuves visuelles)
Captures d'écran des :

Tests Postman (endpoints API)

Interfaces utilisateur

Résultats des opérations
Les critères de réussite incluent :

Fonctionnalités implémentées (100%)

Qualité du code (architecture, lisibilité)

Tests Postman complets

Documentation claire

🚀 Comment Commencer
Initialiser le backend :

bash
Copy
npm init && npm install express body-parser
Configurer le client Dart :

bash
Copy
dart pub add http
Lancer les serveurs :

Backend : node api/server.js

Client : dart run client/main.dart

📌 Bonnes Pratiques
Commits atomiques avec messages explicites

Validation des entrées API

Gestion d'erreurs robuste

Documentation des endpoints
