import 'dart:convert';

import 'package:coffee_shop/src/features/database/database/coffee_database.dart';

class ProductDTO {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final Map<String, double> prices;

  const ProductDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.prices,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    Map<String, double> pricesMap = {};
    for (var price in json['prices']) {
      pricesMap[price['currency']] = double.parse(price['value']);
    }
    return ProductDTO(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      prices: pricesMap,
    );
  }

  factory ProductDTO.fromDB(Product product) {
    Map<String, double> pricesMap = {};
    var jsonPrices = jsonDecode(product.prices);
    jsonPrices.forEach((key, value) {
      pricesMap[key] = double.parse(value.toString());
    });
    return ProductDTO(
        id: product.id,
        name: product.name,
        description: product.description ?? '',
        imageUrl: product.imageUrl!,
        prices: pricesMap);
  }
}
