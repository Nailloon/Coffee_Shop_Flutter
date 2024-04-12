abstract interface class IOrderDataSource {
  Future<bool> postOrder(Map<String, int> orderData);
}
