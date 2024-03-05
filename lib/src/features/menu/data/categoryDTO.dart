import 'package:coffee_shop/src/features/menu/data/productDTO.dart';

class CategoryDTO {
  final String name;
  final List<ProductDTO> products;

  CategoryDTO({required this.name, required this.products});

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<ProductDTO> products = productList.map((product) => ProductDTO.fromJson(product)).toList();

    return CategoryDTO(
      name: json['name'],
      products: products,
    );
  }
}