import 'package:coffee_shop/src/features/menu/models/category_model.dart';
import 'package:coffee_shop/src/features/menu/models/product_model.dart';

abstract interface class IProductRepository {
  Future<bool> loadMoreProductsByCategory(CategoryModel category, int page);
  Future<ProductModel> loadProductByID({required int id});
  Future<void> initialLoadProductsByCategory(CategoryModel categoryData,
      {int page});
  Future<List<ProductModel>> loadAnyProducts(int limitForProducts);
}
