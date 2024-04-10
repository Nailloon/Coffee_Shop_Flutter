abstract interface class IDataProvider {
  Future<List<dynamic>> fetchOnlyCategories();
  Future<List<dynamic>> fetchAnyProducts(int count);
  Future<Map<String, dynamic>> fetchProductsByCategory(
      int categoryId, int limit, int page);
  Future<Map<String, dynamic>> fetchProductByID(int id);
  Future<bool> postOrder(Map<String, int> orderData);
}
