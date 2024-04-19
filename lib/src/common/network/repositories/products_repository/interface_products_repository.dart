import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/models/product_model.dart';

abstract interface class IProductRepository {
  Future<bool> loadMoreProductsByCategory(CategoryData category, int page);
  Future<ProductModel> loadProductByID({required int id});
  Future<void> initialLoadProductsByCategory(CategoryData categoryData,
      {int page});
  Future<List<ProductModel>> loadAnyProducts(int limitForProducts);
}
