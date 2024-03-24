part of 'product_cart_bloc.dart';

sealed class ProductCartEvent {}

class AddProductToCart extends ProductCartEvent {
  AddProductToCart({required this.product});
  final ProductData product;
}

class RemoveProductFromCart extends ProductCartEvent {
  RemoveProductFromCart({required this.product});
  final ProductData product;
}

class ClearProductCart extends ProductCartEvent {}

class ViewAllProductCart extends ProductCartEvent {}
