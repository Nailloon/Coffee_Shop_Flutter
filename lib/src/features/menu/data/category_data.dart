import 'package:coffee_shop/src/features/menu/data/product_dto.dart';
import 'package:coffee_shop/src/features/menu/models/product_model.dart';
import 'package:coffee_shop/src/features/menu/utils/product_mapper.dart';

class CategoryData {
  final int id;
  final String name;
  final List<ProductModel> products;

  const CategoryData(
      {required this.id, required this.name, required this.products});

  factory CategoryData.fromJson(Map<String, dynamic> json, productsJson) {
    var productList = productsJson['data'] as List;
    List<ProductModel> products = productList
        .map((product) => ProductDTO.fromJson(product).toModel())
        .toList();
    return CategoryData(
      name: json['slug'],
      id: json['id'],
      products: products,
    );
  }

  factory CategoryData.fromJsonWithProduct(
      Map<String, dynamic> json, Map<String, dynamic> productsJson) {
    final product = ProductDTO.fromJson(productsJson).toModel();
    return CategoryData(
      name: json['slug'],
      id: json['id'],
      products: [product],
    );
  }

  void addProductIntoCategory(ProductModel product) {
    products.add(product);
  }

  void addListOfProductsIntoCategory(List<ProductModel> products) {
    this.products.addAll(products);
  }
}
