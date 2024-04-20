import 'package:coffee_shop/src/features/database/database/coffee_database.dart';
import 'package:coffee_shop/src/features/menu/data/product_dto.dart';

class CategoryDTO {
  final int id;
  final String name;
  final List<ProductDTO> products;

  CategoryDTO({required this.id, required this.name, required this.products});

  factory CategoryDTO.fromJson(Map<String, dynamic> json, productsJson) {
    var productList = productsJson['data'] as List;
    List<ProductDTO> products =
        productList.map((product) => ProductDTO.fromJson(product)).toList();
    return CategoryDTO(
      name: json['slug'],
      id: json['id'],
      products: products,
    );
  }

  factory CategoryDTO.fromJsonWithProduct(
      Map<String, dynamic> json, Map<String, dynamic> productsJson) {
    final product = ProductDTO.fromJson(productsJson);
    return CategoryDTO(
      name: json['slug'],
      id: json['id'],
      products: [product],
    );
  }

  factory CategoryDTO.fromJsonWithoutProducts(Map<String, dynamic> json) {
    final List<ProductDTO> products = [];
    return CategoryDTO(id: json['id'], name: json['slug'], products: products);
  }

  factory CategoryDTO.fromDB(Category category) {
    final List<ProductDTO> products = [];
    return CategoryDTO(
        id: category.id, name: category.name, products: products);
  }
}
