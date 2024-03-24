import 'package:bloc/bloc.dart';
import 'package:coffee_shop/src/features/cart/data/product_cart.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  ProductCartBloc(this.productsInCart) : super(ProductCartInitial()) {
    on<AddProductToCart>((event, emit) {});
    on<RemoveProductFromCart>((event, emit) {});
    on<ClearProductCart>((event, emit) {});
    on<ViewAllProductCart>((event, emit) {});
  }
  final ProductCart productsInCart;
}
