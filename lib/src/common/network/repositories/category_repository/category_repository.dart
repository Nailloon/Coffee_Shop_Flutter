import 'package:coffee_shop/src/common/network/data_providers/coffeee_api_source.dart';
import 'package:coffee_shop/src/common/network/repositories/category_repository/interface_category_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';

class CategoryRepository implements ICategoryRepository{
  final api = CoffeShopApiDataSource();
  static const int limitForPage = 25;

  @override
  Future<List<CategoryData>> loadOnlyCategories() async {
    List<dynamic> categoriesData = await api.fetchOnlyCategories();
    List<CategoryData> categories = [];

    for (var categoryData in categoriesData) {
      CategoryData category = CategoryData(
          id: categoryData['id'], name: categoryData['slug'], products: []);
      categories.add(category);
    }

    return categories;
  }
  
}