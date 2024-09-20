import 'package:coffee_shop/src/features/menu/data/product_dto.dart';
import 'package:coffee_shop/src/features/menu/models/product_model.dart';
import 'package:coffee_shop/src/features/menu/utils/product_mapper.dart';

class CategoryModel {
  final int id;
  final String name;
  final List<ProductModel> products;

  const CategoryModel(
      {required this.id, required this.name, required this.products});

  void addProductIntoCategory(ProductDTO product) {
    products.add(product.toModel());
  }

  void addListOfProductsIntoCategory(List<ProductModel> products) {
    this.products.addAll(products);
  }
}
