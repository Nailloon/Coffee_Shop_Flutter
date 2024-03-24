import 'package:bloc/bloc.dart';
import 'package:coffee_shop/src/features/cart/data/product_cart.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:flutter/material.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  ProductCartBloc(this.productsInCart, this.price, this.currency, ) : super(ProductCartInitial()) {
    on<AddProductToCart>((event, emit) {
      debugPrint('add');
      productsInCart.addProduct(event.product);
      price = price + event.product.prices[currency]!;
      emit(ProductCartChanged(productsInCart, price));
    });
    on<RemoveProductFromCart>((event, emit) {
      debugPrint('remove');
      productsInCart.removeProduct(event.product);
      price = price - event.product.prices[currency]!;
      if (productsInCart.emptyCart()){
        emit(EmptyProductCart());
      }
      else{
        emit(ProductCartChanged(productsInCart, price));
      }
    });
    on<ClearProductCart>((event, emit) {
      debugPrint('clear');
      productsInCart.clearCart();
      price = 0;
      emit(EmptyProductCart());
    });
    on<ViewAllProductCart>((event, emit) {});
  }
  final ProductCart productsInCart;
  double price;
  final String currency;
}
