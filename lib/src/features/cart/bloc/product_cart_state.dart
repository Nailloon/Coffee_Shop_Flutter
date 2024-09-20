part of 'product_cart_bloc.dart';

sealed class ProductCartState {
  const ProductCartState();
}

final class ProductCartInitial extends ProductCartState {}

final class ProductCartChanged extends ProductCartState {
  final ProductCart cart;
  final double price;
  const ProductCartChanged(this.cart, this.price);
}

final class EmptyProductCart extends ProductCartState {}

final class AllProductsInCartAsList extends ProductCartState {
  final List<ProductModel> cart;
  final ProductCart productCart;
  const AllProductsInCartAsList(this.cart, this.productCart);
}

final class ProductCartPostOrderComplete extends ProductCartState {
  final bool complete;

  const ProductCartPostOrderComplete({required this.complete});
}

final class ProductCartPostOrderFailure extends ProductCartState {
  final Object? exception;

  const ProductCartPostOrderFailure({required this.exception});
}
