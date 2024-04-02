import 'package:coffee_shop/src/features/database/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

final class DataBaseSource implements ISavableDataSource {
  @override
  bool changeCategoty(CategoryData category) {
    // TODO: implement changeCategoty
    throw UnimplementedError();
  }

  @override
  bool changeProduct(ProductData product) {
    // TODO: implement changeProduct
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryData>> fetchOnlyCategories() {
    // TODO: implement fetchOnlyCategories
    throw UnimplementedError();
  }

  @override
  Future<ProductData> fetchProductByID(int id) {
    // TODO: implement fetchProductByID
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> fetchProductsByCategory(int categoryId, int limit, int page) {
    // TODO: implement fetchProductsByCategory
    throw UnimplementedError();
  }

  @override
  void saveCategoriesWithProducts(List<CategoryData> categories) {
    // TODO: implement saveCategoriesWithProducts
  }

  @override
  void saveCategory(CategoryData category) {
    // TODO: implement saveCategory
  }

  @override
  void saveProduct(ProductData product) {
    // TODO: implement saveProduct
  }
  
}