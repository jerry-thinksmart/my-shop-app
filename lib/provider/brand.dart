import "dart:js_interop";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "dart:convert";
import "package:http/http.dart" as http;

class BrandModel {
  String? id;
  String title;
  String description;
  String? imageUrl;

  BrandModel({
    this.id,
    required this.title,
    required this.description,
    this.imageUrl,
  });
}

class Brand with ChangeNotifier {
  List<BrandModel> brand = [];

  List get brandValue => brand;

  Future<void> addBrand(BrandModel brandvalues) async {
    final url = Uri.parse(
      'https://ecommerce-app1-b794b-default-rtdb.firebaseio.com/brand.json',
    );

    await http.post(
      url,
      body: json.encode({
        'title': brandvalues.title,
        'description': brandvalues.description,
        'imageUrl': brandvalues.imageUrl,
        // 'created_at': DateTime.now(),
      }),
    );
  }

  Future<void> getBrands() async {
    final url = Uri.parse(
      "https://ecommerce-app1-b794b-default-rtdb.firebaseio.com/brand.json",
    );

    try {
      final request = await http.get(url);
      final response = json.decode(request.body);
      notifyListeners();
      print(response);
    } catch (error) {}
  }
}
