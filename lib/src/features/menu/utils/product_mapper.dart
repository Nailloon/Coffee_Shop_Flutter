import 'package:coffee_shop/src/features/menu/data/product_dto.dart';
import 'package:coffee_shop/src/features/menu/models/product_model.dart';

extension ProductMapper on ProductDTO {
  ProductModel toModel() => ProductModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      prices: prices);
}
