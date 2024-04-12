import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class IProductRepository {
  Future<bool> loadMoreProductsByCategory(CategoryData category, int page);
  Future<ProductData> loadProductByID({required int id});
  Future<void> initialLoadProductsByCategory(CategoryData categoryData,
      {int page});
  Future<List<ProductData>> loadAnyProducts(int limitForProducts);
}
