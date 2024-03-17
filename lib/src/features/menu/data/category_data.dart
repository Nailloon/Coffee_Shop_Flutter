import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class CategoryData {
  final String name;
  final List<ProductData> products;

  const CategoryData({required this.name, required this.products});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<ProductData> products =
        productList.map((product) => ProductData.fromJson(product)).toList();

    return CategoryData(
      name: json['name'],
      products: products,
    );
  }
}
