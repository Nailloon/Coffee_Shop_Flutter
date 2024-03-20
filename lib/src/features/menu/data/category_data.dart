import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:flutter/material.dart';

class CategoryData {
  final int id;
  final String name;
  final List<ProductData> products;

  const CategoryData({required this.id, required this.name, required this.products});

  factory CategoryData.fromJson(Map<String, dynamic> json, productsJson) {
    var productList = productsJson['data'] as List;
    List<ProductData> products =
        productList.map((product) => ProductData.fromJson(product)).toList();
    debugPrint(products.toString());
    debugPrint(json.toString());
    return CategoryData(
      name: json['slug'],
      id: json['id'],
      products: products,
    );
  }
}
