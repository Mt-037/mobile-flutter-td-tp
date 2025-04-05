import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const String apiUrl = 'http://localhost:3000';

class Produit {
  final int id;
  final String nom;
  final double prix;
  final int stock;

  Produit({
    required this.id,
    required this.nom,
    required this.prix,
    required this.stock,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nom': nom,
    'prix': prix,
    'stock': stock,
  };

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      id: json['id'],
      nom: json['nom'],
      prix: json['prix'] is int ? json['prix'].toDouble() : json['prix'],
      stock: json['stock'],
    );
  }
}

class Commande {
  final int id;
  final List<Map<String, dynamic>> produits;

  Commande({required this.id, required this.produits});

  Map<String, dynamic> toJson() => {
    'id': id,
    'produits': produits,
  };

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['id'],
      produits: List<Map<String, dynamic>>.from(json['produits']),
    );
  }
}

class ApiService {
  static Future<List<Produit>> getProduits() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/produits'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((json) => Produit.fromJson(json)).toList();
      } else {
        throw HttpException(
            'Failed to load products - Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<List<Commande>> getCommandes() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/commandes'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((json) => Commande.fromJson(json)).toList();
      } else {
        throw HttpException(
            'Failed to load orders - Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Produit> createProduit(Produit produit) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/produits'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(produit.toJson()),
      );
      if (response.statusCode == 201) {
        return Produit.fromJson(json.decode(response.body));
      } else {
        throw HttpException(
            'Failed to create product - Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Commande> createCommande(
      List<Map<String, dynamic>> produits) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/commandes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'produits': produits}),
      );
      if (response.statusCode == 201) {
        return Commande.fromJson(json.decode(response.body));
      } else {
        throw HttpException(
            'Failed to create order - Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

class ShopUI {
  static void printMenu() {
    print('\n🎮 Welcome to the KOZYGAMING Shop! 🎮');
    print('1. View Products ');
    print('2. View Orders ');
    print('3. Add a Product ');
    print('4. Create an Order ');
    print('5. Exit ');
    print('Please select an option:');
  }

  static Future<void> viewProducts() async {
    try {
      final produits = await ApiService.getProduits();
      if (produits.isEmpty) {
        print('No products available. ');
      } else {
        print(' List of Products:');
        for (final p in produits) {
          print('${p.nom} - Price: ${p.prix}€ - Stock: ${p.stock}');
        }
      }
    } catch (e) {
      print(' Error fetching products: $e');
    }
  }

  static Future<void> viewOrders() async {
    try {
      final commandes = await ApiService.getCommandes();
      if (commandes.isEmpty) {
        print('No orders available. ');
      } else {
        print(' List of Orders:');
        for (final c in commandes) {
          print('Order ID: ${c.id}');
          print('Products in this order:');
          for (final p in c.produits) {
            print('  Product ID: ${p["id"]} - Quantity: ${p["quantite"]}');
          }
        }
      }
    } catch (e) {
      print(' Error fetching orders: $e');
    }
  }

  static Future<void> addProduct() async {
    try {
      print(' Enter Product Name:');
      final name = stdin.readLineSync()?.trim() ?? '';

      print(' Enter Product Price:');
      final price = double.tryParse(stdin.readLineSync()?.trim() ?? '');

      print('Enter Product Stock:');
      final stock = int.tryParse(stdin.readLineSync()?.trim() ?? '');

      if (name.isEmpty || price == null || stock == null) {
        print(' Invalid input. Product not added.');
        return;
      }

      final newProduit = Produit(id: 0, nom: name, prix: price, stock: stock);
      final createdProduit = await ApiService.createProduit(newProduit);
      print(
          ' Product added: ${createdProduit.nom} with price ${createdProduit.prix}€ and stock ${createdProduit.stock} 🏷️');
    } catch (e) {
      print(' Error creating product: $e');
    }
  }

  static Future<void> createOrder() async {
    try {
      final produits = await ApiService.getProduits();
      if (produits.isEmpty) {
        print(' No products available to order.');
        return;
      }

      print(
          '🛒 Enter Product ID and Quantity to order (e.g., 1 2 for Product 1 with Quantity 2):');
      final input = stdin.readLineSync()?.trim() ?? '';
      final inputs = input.split(' ');

      if (inputs.length != 2) {
        print(' Invalid input. Order not created.');
        return;
      }

      final productId = int.tryParse(inputs[0]) ?? -1;
      final quantity = int.tryParse(inputs[1]) ?? -1;

      if (productId == -1 || quantity == -1) {
        print('Invalid product ID or quantity.');
        return;
      }

      final selectedProduit = produits.firstWhere(
            (p) => p.id == productId,
        orElse: () => throw Exception('Product not found'),
      );

      if (selectedProduit.stock < quantity) {
        print(' Not enough stock available.');
        return;
      }

      final orderProducts = [
        {'id': selectedProduit.id, 'quantite': quantity}
      ];
      final commande = await ApiService.createCommande(orderProducts);
      print(' Order created with ID: ${commande.id} ');
    } catch (e) {
      print(' Error creating order: $e');
    }
  }
}

Future<void> main() async {
  bool running = true;

  while (running) {
    ShopUI.printMenu();
    final choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        await ShopUI.viewProducts();
        break;
      case '2':
        await ShopUI.viewOrders();
        break;
      case '3':
        await ShopUI.addProduct();
        break;
      case '4':
        await ShopUI.createOrder();
        break;
      case '5':
        running = false;
        print(' Thank you for your visit ');
        break;
      default:
        print('⚠ Invalid choice, please select again.');
        break;
    }
  }
}