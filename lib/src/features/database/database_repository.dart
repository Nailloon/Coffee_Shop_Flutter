import 'package:coffee_shop/src/features/database/database_data_source.dart';
import 'package:coffee_shop/src/features/database/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/database/interface_savable_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class DatabaseRepository implements ISavableRepository {  
  ISavableDataSource database = DataBaseSource();
  final int limitForPage = 25;
  int initialOffset = 0;
  @override
  Future<List<CategoryData>> initialLoadCategoriesWithProducts(int limitForCategory, int page) async{
    List<CategoryData> categories = await database.fetchOnlyCategories();
    for (var category in categories){
      List<ProductData> products = await database.fetchProductsByCategory(category.id, limitForPage, initialOffset);
      for (var product in products){
        category.addProductIntoCategory(product);
      }
    }
    return categories;
  }

  @override
  void saveCategories(List<CategoryData> categories) {
    database.saveCategoriesWithProducts(categories);
  }

  @override
  void saveProducts(List<ProductData> products, int categoryId) {
    database.saveProducts(products, categoryId);
  }

  
}