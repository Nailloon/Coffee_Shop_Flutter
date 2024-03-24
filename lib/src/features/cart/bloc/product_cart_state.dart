part of 'product_cart_bloc.dart';

sealed class ProductCartState {}

class ProductCartInitial extends ProductCartState {}

class ProductCartChanged extends ProductCartState {
  final ProductCart cart;
  final double price;
  ProductCartChanged(this.cart, this.price);
}

class EmptyProductCart extends ProductCartState {}

class AllProductsInCart extends ProductCartState{
  final List<ProductData> cart;
  AllProductsInCart(this.cart);
}