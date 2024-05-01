abstract interface class IOrderRepository {
  Future<bool> sendOrder({required Map<String, int> products});
}
