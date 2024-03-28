part of 'product_cart_bloc.dart';

sealed class ProductCartState {
  const ProductCartState();
}

class ProductCartInitial extends ProductCartState {}

class ProductCartChanged extends ProductCartState {
  final ProductCart cart;
  final double price;
  const ProductCartChanged(this.cart, this.price);
}

class EmptyProductCart extends ProductCartState {}

class AllProductsInCartAsList extends ProductCartState {
  final List<ProductData> cart;
  final ProductCart productCart;
  const AllProductsInCartAsList(this.cart, this.productCart);
}

class ProductCartPostOrderComplete extends ProductCartState {
  final bool complete;

  const ProductCartPostOrderComplete({required this.complete});
}

class ProductCartPostOrderFailure extends ProductCartState {
  final Object? exception;

  const ProductCartPostOrderFailure({required this.exception});
}
