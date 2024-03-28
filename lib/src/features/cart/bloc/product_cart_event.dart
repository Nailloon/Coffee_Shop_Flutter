part of 'product_cart_bloc.dart';

sealed class ProductCartEvent {
  const ProductCartEvent();
}

class AddProductToCart extends ProductCartEvent {
  const AddProductToCart({required this.product});
  final ProductData product;
}

class RemoveProductFromCart extends ProductCartEvent {
  const RemoveProductFromCart({required this.product});
  final ProductData product;
}

class ClearProductCart extends ProductCartEvent {}

class ViewAllProductCart extends ProductCartEvent {}

class ReturnToMainScreen extends ProductCartEvent {}

class PostOrderEvent extends ProductCartEvent {
  final ProductCart products;
  const PostOrderEvent({required this.products});
}
