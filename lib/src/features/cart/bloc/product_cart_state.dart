part of 'product_cart_bloc.dart';

sealed class ProductCartState {}

class ProductCartInitial extends ProductCartState {}

class ProductCartChanged extends ProductCartState {
  final ProductCart cart;
  final double price;
  ProductCartChanged(this.cart, this.price);
}

class EmptyProductCart extends ProductCartState {}

class AllProductsInCartAsList extends ProductCartState {
  final List<ProductData> cart;
  final ProductCart productCart;
  AllProductsInCartAsList(this.cart, this.productCart);
}

class ProductCartPostOrderComplete extends ProductCartState {
  final String complete;

  ProductCartPostOrderComplete({required this.complete});
}

class ProductCartPostOrderFailure extends ProductCartState {
  final Object? exception;

  ProductCartPostOrderFailure({required this.exception});
}
