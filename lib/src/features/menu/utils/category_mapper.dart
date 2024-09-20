import 'package:coffee_shop/src/features/menu/data/category_dto.dart';
import 'package:coffee_shop/src/features/menu/models/category_model.dart';
import 'package:coffee_shop/src/features/menu/utils/product_mapper.dart';

extension CategotyMapper on CategoryDTO {
  CategoryModel toModel() => CategoryModel(
      id: id, name: name, products: products.map((e) => e.toModel()).toList());
}
