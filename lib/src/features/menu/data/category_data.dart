import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class CategoryData {
  final int id;
  final String name;
  final List<ProductData> products;

  const CategoryData(
      {required this.id, required this.name, required this.products});

  factory CategoryData.fromJson(Map<String, dynamic> json, productsJson) {
    var productList = productsJson['data'] as List;
    List<ProductData> products =
        productList.map((product) => ProductData.fromJson(product)).toList();
    return CategoryData(
      name: json['slug'],
      id: json['id'],
      products: products,
    );
  }

  factory CategoryData.fromJsonWithProduct(
      Map<String, dynamic> json, Map<String, dynamic> productsJson) {
    final product = ProductData.fromJson(productsJson);
    return CategoryData(
      name: json['slug'],
      id: json['id'],
      products: [product],
    );
  }

  void addProductIntoCategory(ProductData product){
    products.add(product);
  }
}
