import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class IProductsDataSource {
  Future<List<ProductData>> fetchAnyProducts(int count);
  Future<List<ProductData>> fetchProductsByCategory(
      int categoryId, int limit, int page);
  Future<ProductData> fetchProductByID(int id);
}
