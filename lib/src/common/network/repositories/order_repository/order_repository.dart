import 'package:coffee_shop/src/common/network/data_sources/order_data_source/interface_order_data_source.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository/interface_order_repository.dart';

class OrderRepository implements IOrderRepository {
  final IOrderDataSource orderDataSource;
  const OrderRepository(this.orderDataSource);

  @override
  Future<bool> sendOrder({required Map<String, int> products}) async {
    return await orderDataSource.postOrder(products);
  }
}
