# Travaux Dirigés 1 : Gestion d’un Système de Commandes en Dart  

## 📌 Contexte  
Une petite entreprise souhaite automatiser la gestion de ses commandes.  
Votre mission est de développer un système permettant :  
✅ d'ajouter des produits,  
✅ de créer des commandes,  
✅ d'utiliser des fonctions avancées sur les listes,  
✅ et de gérer les erreurs éventuelles.  

---

## 🎯 Objectifs  
- **Appliquer la programmation orientée objet (POO)** en Dart.  
- **Utiliser des listes** et appliquer des méthodes comme **filter, map, find**.  
- **Utiliser des fonctions de haut niveau et des expressions lambda** (_arrow functions_).  
- **Gérer les exceptions** pour prévenir les erreurs.  

---

## 🚀 Problème  
Vous devez implémenter un système de gestion des commandes qui inclut les fonctionnalités suivantes :  

### **1️⃣ Création d’une classe `Produit`**
#### **Attributs :**  
- `nom` (_String_)  
- `prix` (_double_)  
- `stock` (_int_)  
- `categorie` (_String_)  

#### **Méthodes :**  
- `afficherDetails()` : Affiche les informations du produit.  

---

### **2️⃣ Création d’une classe `Commande`**
#### **Attributs :**  
- `id` (_int_)  
- `produits` (_Liste de Produit avec quantités associées_)  
- `total` (_double_, calculé automatiquement)  

#### **Méthodes :**  
- `ajouterProduit(Produit produit, int quantite)` :  
  ➝ Ajoute un produit à la commande et met à jour le stock.  
- `calculerTotal()` :  
  ➝ Calcule le prix total de la commande.  
- `afficherCommande()` :  
  ➝ Affiche les détails de la commande.  

---

### **3️⃣ Gestion des Exceptions**
- Si un produit n’a pas **assez de stock**, lever une exception `StockInsuffisantException`.  
- Si une commande est **vide**, lever une exception `CommandeVideException` lors de l’affichage.  

---


---

## 📌 **Travail demandé**  
### **🔹 Partie 1 : Implémentation des classes**
1. Compléter la classe `Produit` et la classe `Commande`.  
2. Ajouter la gestion des exceptions.  

### **🔹 Partie 2 : Manipulation des listes et Programmation fonctionnelle**
1. Écrire une fonction `rechercherProduitParNom(String nom)` pour retrouver un produit dans une liste globale.  
2. Utiliser `map()` pour afficher une liste formatée des produits commandés.  
3. Filtrer les produits coûtant plus de 50 DH avec `filter()`.  
4. Trouver le produit le plus cher avec `reduce()`.  
5. Implémenter une unction pour appliquer une remise de 10% sur tous les produits de la catégorie (Phone).  
6. Écrire une **fonction de haut niveau** qui applique une transformation aux prix des produits.  
7. Utiliser `forEach()` pour afficher tous les produits commandés.  

---

🛠 **Bonne programmation et bon apprentissage !** 
