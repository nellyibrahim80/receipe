import 'dart:convert';
import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(), // Ensure the 'price' is treated as double
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late List<Product> productList;

  @override
  void initState() {
    super.initState();
    // Load products from the JSON file (you can replace this with your own file loading logic)
    String jsonContent = '[{"id":1,"name":"Product A","price":19.99},{"id":2,"name":"Product B","price":29.99}]';
    List<dynamic> jsonList = json.decode(jsonContent);
    productList = jsonList.map((json) => Product.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          Product product = productList[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            // Add more ListTile customization as needed
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProductList(),
  ));
}
