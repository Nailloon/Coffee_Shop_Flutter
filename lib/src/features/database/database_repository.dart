import 'package:coffee_shop/src/features/database/data_source/database_data_source.dart';
import 'package:coffee_shop/src/features/database/data_source/interface_savable_data_source.dart';
import 'package:coffee_shop/src/features/database/interface_savable_repository.dart';
import 'package:coffee_shop/src/features/database/savable_category_repository/interface_savable_category_repository.dart';
import 'package:coffee_shop/src/features/database/savable_category_repository/savable_category_repository.dart';
import 'package:coffee_shop/src/features/database/savable_product_repository/interface_savable_product_repository.dart';
import 'package:coffee_shop/src/features/database/savable_product_repository/savable_product_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class DatabaseRepository implements ISavableRepository{
  static ISavableDataSource dataSource = DataBaseSource();
  ISavableCategoryRepository categoryRepository = SavableCategoryRepository(dataSource);
  ISavableProductRepository productRepository = SavableProductRepository(dataSource);
  static const int limitPerPage = 25;
  static const int initialOffset = 0;
  @override
  Future<List<CategoryData>> initialLoadCategoriesWithProducts(
      int limitForCategory) async {
    List<CategoryData> categories = await categoryRepository.loadCategories();
    for (var category in categories) {
      List<ProductData> products = await productRepository
          .loadMoreProductsByCategory(category, limitPerPage, initialOffset);
      for (var product in products) {
        category.addProductIntoCategory(product);
      }
    }
    return categories;
  }

  @override
  void saveCategories(List<CategoryData> categories) {
    categoryRepository.saveCategories(categories);
  }

  @override
  void saveProducts(List<ProductData> products, int categoryId) {
    productRepository.saveProducts(products, categoryId);
  }

  @override
  Future<bool> loadMoreProductsByCategory(CategoryData category, int page,
      {int limitForCategory = limitPerPage}) async {
    int count = 0;
    final int offset = page * limitPerPage;
    List<ProductData> products = await productRepository
        .loadMoreProductsByCategory(category, limitPerPage, offset);
    for (var product in products) {
      category.addProductIntoCategory(product);
      count += 1;
    }
    if (count < limitPerPage) {
      return true;
    } else {
      return false;
    }
  }
}
