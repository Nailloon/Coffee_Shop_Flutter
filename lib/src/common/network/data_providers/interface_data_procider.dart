abstract interface class IDataProvider {
  Future<List<dynamic>> loadOnlyCategories();
  Future<List<dynamic>> loadAnyProducts(int count);
  Future<Map<String,dynamic>> loadProductsByCategory(int categoryId,int limit, int page);
  Future<Map<String,dynamic>> loadProductByID(int id);
}