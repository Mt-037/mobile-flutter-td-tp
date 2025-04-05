import 'produit.dart';

class Commande {
  int id;
  List<Map<String, dynamic>> produits;

  Commande({required this.id, required this.produits});

  // Convert JSON to Commande object
  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'],
      produits: List<Map<String, dynamic>>.from(json['produits']),
    );
  }

  // Convert Commande object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'produits': produits};
  }
}