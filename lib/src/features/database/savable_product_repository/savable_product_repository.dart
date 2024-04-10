import 'package:coffee_shop/src/features/database/data_source/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/database/savable_product_repository/interface_savable_product_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class SavableProductRepository implements ISavableProductRepository {
  final ISavableDataSource dataSource;
  SavableProductRepository(this.dataSource);

  @override
  Future<List<ProductData>> loadMoreProductsByCategory(
      CategoryData category, int limitForCategory, int initialOffset) async {
    List<ProductData> productsByCategory = await dataSource
        .fetchProductsByCategory(category.id, limitForCategory, initialOffset);
    return productsByCategory;
  }

  @override
  void saveProducts(List<ProductData> products, int categoryId) {
    dataSource.saveProducts(products, categoryId);
  }
}
