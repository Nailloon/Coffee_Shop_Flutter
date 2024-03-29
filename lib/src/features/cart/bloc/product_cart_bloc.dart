import 'package:bloc/bloc.dart';
import 'package:coffee_shop/src/common/network/repositories/interface_repository.dart';
import 'package:coffee_shop/src/features/cart/data/product_cart.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:flutter/material.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

final class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  ProductCartBloc(
    this.productsInCart,
    this.price,
    this.currency,
    this.coffeeRepository,
  ) : super(ProductCartInitial()) {
    on<AddProductToCart>(_handleAddProductToCart);
    on<RemoveProductFromCart>(_handleRemoveProductFromCart);
    on<ClearProductCart>(_handleClearProductCart);
    on<ViewAllProductCart>(_handleViewAllProductCart);
    on<ReturnToMainScreen>(_handleReturnToMainScreen);
    on<PostOrderEvent>(_handlePostOrderEvent);
  }

  final ProductCart productsInCart;
  double price;
  final String currency;
  final IRepository coffeeRepository;

  void _handleAddProductToCart(
      AddProductToCart event, Emitter<ProductCartState> emit) {
    debugPrint('add');
    productsInCart.addProduct(event.product);
    price = price + event.product.prices[currency]!;
    emit(ProductCartChanged(productsInCart, price));
  }

  void _handleRemoveProductFromCart(
      RemoveProductFromCart event, Emitter<ProductCartState> emit) {
    debugPrint('remove');
    productsInCart.removeProduct(event.product);
    price = price - event.product.prices[currency]!;
    if (productsInCart.emptyCart()) {
      emit(EmptyProductCart());
    } else {
      emit(ProductCartChanged(productsInCart, price));
    }
  }

  void _handleClearProductCart(
      ClearProductCart event, Emitter<ProductCartState> emit) {
    debugPrint('clear');
    productsInCart.clearCart();
    price = 0;
    emit(EmptyProductCart());
  }

  void _handleViewAllProductCart(
      ViewAllProductCart event, Emitter<ProductCartState> emit) {
    debugPrint('appearBottomSheet');
    List<ProductData> result = [];
    productsInCart.getProducts().forEach((product, count) {
      for (int i = 0; i < count; i++) {
        result.add(product);
      }
    });
    emit(AllProductsInCartAsList(result, productsInCart));
  }

  void _handleReturnToMainScreen(
      ReturnToMainScreen event, Emitter<ProductCartState> emit) {
    emit(ProductCartChanged(productsInCart, price));
  }

  void _handlePostOrderEvent(
      PostOrderEvent event, Emitter<ProductCartState> emit) async {
    final Map<String, int> productAndQuantity = event.products.getIdAndCount();
    try {
      debugPrint(productAndQuantity.toString());
      final response =
          await coffeeRepository.sendOrder(products: productAndQuantity);
      emit(ProductCartPostOrderComplete(complete: response));
    } catch (e) {
      emit(ProductCartPostOrderFailure(exception: e));
    }
  }
}
