import 'package:coffee_shop/src/common/network/data_sources/coffeee_api_source.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/interface_products_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class ProductRepository implements IProductRepository {
  final api = CoffeShopApiDataSource();
  static const int limitForPage = 25;
  @override
  Future<bool> loadMoreProductsByCategory(
      CategoryData category, int page) async {
    final Map<String, dynamic> jsonResponse =
        await api.fetchProductsByCategory(category.id, limitForPage, page);
    int count = 0;
    final jsonResponseAsList = returnJsonDataAsList(jsonResponse);
    for (var productJson in jsonResponseAsList) {
      category.addProductIntoCategory(ProductData.fromJson(productJson));
      count += 1;
    }
    if (count < limitForPage) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<ProductData> loadProductByID({required int id}) async {
    final Map<String, dynamic> jsonResponse = await api.fetchProductByID(id);

    return ProductData.fromJson(jsonResponse);
  }

  @override
  Future<void> loadProductsByCategory(CategoryData categoryData,
      {int id = 1, int limit = limitForPage, int page = 0}) async {
    final Map<String, dynamic> jsonResponse =
        await api.fetchProductsByCategory(id, limit, page);
    final jsonResponseAsList = returnJsonDataAsList(jsonResponse);
    for (var productJson in jsonResponseAsList) {
      categoryData.addProductIntoCategory(ProductData.fromJson(productJson));
    }
  }

  @override
  Future<List<CategoryData>> loadAnyProducts(int limitForProducts) async {
    var data = await api.fetchAnyProducts(limitForProducts);
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
}
