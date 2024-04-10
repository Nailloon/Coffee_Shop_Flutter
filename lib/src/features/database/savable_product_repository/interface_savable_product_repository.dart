import 'package:coffee_shop/src/features/database/data_source/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

abstract interface class ISavableProductRepository{
  void saveProducts(List<ProductData> products, int categoryId);
  Future<List<ProductData>> loadMoreProductsByCategory(
      CategoryData category, int limitPerPage, int offset);
  ISavableProductRepository(ISavableDataSource dataSource);
}
