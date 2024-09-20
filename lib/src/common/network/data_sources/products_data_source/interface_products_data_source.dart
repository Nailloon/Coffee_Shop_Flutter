import 'package:coffee_shop/src/features/menu/data/product_dto.dart';

abstract interface class IProductsDataSource {
  Future<List<ProductDTO>> fetchAnyProducts(int count);
  Future<List<ProductDTO>> fetchProductsByCategory(
      int categoryId, int limit, int page);
  Future<ProductDTO> fetchProductByID(int id);
}
