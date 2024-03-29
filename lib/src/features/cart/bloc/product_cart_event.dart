part of 'product_cart_bloc.dart';

sealed class ProductCartEvent {
  const ProductCartEvent();
}

final class AddProductToCart extends ProductCartEvent {
  const AddProductToCart({required this.product});
  final ProductData product;
}

final class RemoveProductFromCart extends ProductCartEvent {
  const RemoveProductFromCart({required this.product});
  final ProductData product;
}

final class ClearProductCart extends ProductCartEvent {}

final class ViewAllProductCart extends ProductCartEvent {}

final class ReturnToMainScreen extends ProductCartEvent {}

final class PostOrderEvent extends ProductCartEvent {
  final ProductCart products;
  const PostOrderEvent({required this.products});
}
