import 'package:coffee_shop/src/common/network/data_providers/coffeee_api_provider.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class CoffeeShopRepository implements IRepository {
  final api = CoffeShopApiDataProvider();
  
  @override
  Future<CategoryData> fetchProductsByCategory(categoryData,
      {int id = 1, int limit = 10, int page = 0}) async {
    final Map<String, dynamic> jsonResponse =
        await api.loadProductsByCategory(id, limit, page);
    
    return CategoryData.fromJson(categoryData, jsonResponse);
  }

  @override
  Future<List<CategoryData>> fetchCategoriesWithProducts(
      {int limitForCategory = 8, int page = 0}) async {
    List<dynamic> categoriesData = await api.loadOnlyCategories();
    List<CategoryData> categories = [];

    for (var categoryData in categoriesData) {
      var id = categoryData['id'];
      CategoryData category = await fetchProductsByCategory(categoryData,
          id: id, limit: limitForCategory, page: page);
      categories.add(category);
    }

    return categories;
  }

  @override
  Future<List<CategoryData>> fetchAnyProducts(int limitForProducts) async {
    var data = await api.loadAnyProducts(limitForProducts);
    List<CategoryData> categories = [];

    for (var productJson in data) {
      var category = CategoryData.fromJsonWithProduct(
          productJson['category'], productJson);
      bool existing = false;
      for (var existingCategory in categories) {
        if (existingCategory.id == category.id) {
          existingCategory.products.addAll(category.products);
          existing = true;
          break;
        }
      }
      if (!existing) {
        categories.add(category);
      }
    }

    return categories;
  }

  @override
  Future<List<CategoryData>> fetchOnlyCategories() async {
    List<dynamic> categoriesData = await api.loadOnlyCategories();
    List<CategoryData> categories = [];

    for (var categoryData in categoriesData) {
      CategoryData category = CategoryData(
          id: categoryData['id'], name: categoryData['slug'], products: []);
      categories.add(category);
    }

    return categories;
  }

  @override
  Future<ProductData> fetchProductByID({int id = 0}) async {
    final Map<String, dynamic> jsonResponse = await api.loadProductByID(id);

    return ProductData.fromJson(jsonResponse);
  }
  @override
  Future<String> sendOrder({required Map<String, int> products}) async{
    return await api.postOrder(products);
  }
}
