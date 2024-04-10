import 'package:coffee_shop/src/features/database/data_source/database_data_source.dart';
import 'package:coffee_shop/src/features/database/data_source/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/database/savable_product_repository/interface_savable_product_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class SavableProductRepository implements ISavableProductRepository{
  ISavableDataSource database = DataBaseSource();
  @override
  Future<List<ProductData>> loadMoreProductsByCategory(
      CategoryData category, int limitForCategory, int initialOffset) async {
    List<ProductData> productsByCategory = await database
        .fetchProductsByCategory(category.id, limitForCategory, initialOffset);
    return productsByCategory;
  }

  @override
  void saveProducts(List<ProductData> products, int categoryId) {
    database.saveProducts(products, categoryId);
  }
}
