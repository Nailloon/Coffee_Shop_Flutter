import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class ISavableProductRepository {
  void saveProducts(List<ProductData> products, int categoryId);
  Future<List<ProductData>> loadMoreProductsByCategory(
      CategoryData category, int limitPerPage, int offset);
}
