class Produit {
  int id;
  String nom;
  double prix;
  int stock;

  Produit({
    required this.id,
    required this.nom,
    required this.prix,
    required this.stock,
  });

  // Convert JSON to Produit object
  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'],
      nom: json['nom'],
      prix: json['prix'].toDouble(),
      stock: json['stock'],
    );
  }

  // Convert Produit object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'nom': nom, 'prix': prix, 'stock': stock};
  }
}