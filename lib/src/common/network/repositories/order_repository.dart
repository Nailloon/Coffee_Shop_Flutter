import 'package:coffee_shop/src/common/network/data_providers/coffeee_api_source.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_order_repository.dart';

class OrderRepository implements IOrderRepository {
  final api = CoffeShopApiDataSource();
  @override
  Future<bool> sendOrder({required Map<String, int> products}) async {
    return await api.postOrder(products);
  }
}
