import 'package:bloc/bloc.dart';
import 'package:coffee_shop/src/common/functions/price_functions.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository/interface_order_repository.dart';
import 'package:coffee_shop/src/features/cart/data/product_cart.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

final class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  ProductCartBloc(
    this.productsInCart,
    this.price,
    this.currency,
    this.orderRepository,
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
  final IOrderRepository orderRepository;

  void _handleAddProductToCart(
      AddProductToCart event, Emitter<ProductCartState> emit) {
    productsInCart.addProduct(event.product);
    price = price + priceExist(event.product);
    emit(ProductCartChanged(productsInCart, price));
  }

  void _handleRemoveProductFromCart(
      RemoveProductFromCart event, Emitter<ProductCartState> emit) {
    productsInCart.removeProduct(event.product);
    price = price - priceExist(event.product);
    if (productsInCart.emptyCart()) {
      emit(EmptyProductCart());
    } else {
      emit(ProductCartChanged(productsInCart, price));
    }
  }

  void _handleClearProductCart(
      ClearProductCart event, Emitter<ProductCartState> emit) {
    productsInCart.clearCart();
    price = 0;
    emit(EmptyProductCart());
  }

  void _handleViewAllProductCart(
      ViewAllProductCart event, Emitter<ProductCartState> emit) {
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
      final response =
          await orderRepository.sendOrder(products: productAndQuantity);
      emit(ProductCartPostOrderComplete(complete: response));
    } catch (e) {
      emit(ProductCartPostOrderFailure(exception: e));
    }
  }
}
