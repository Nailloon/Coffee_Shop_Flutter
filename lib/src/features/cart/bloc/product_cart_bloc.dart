import 'package:coffee_shop/src/features/cart/data/product_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  ProductCartBloc(this.productsInCart) : super(ProductCartInitial()) {
    on<ProductCartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  final ProductCart productsInCart;
}