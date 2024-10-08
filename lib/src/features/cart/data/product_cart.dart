import 'package:coffee_shop/src/features/menu/models/product_model.dart';

class ProductCart {
  final Map<ProductModel, int> _productsInCart = {};

  Map<ProductModel, int> get products => Map.from(_productsInCart);

  void addProduct(ProductModel product) {
    if (_productsInCart.containsKey(product)) {
      _productsInCart[product] = (_productsInCart[product] ?? 0) + 1;
    } else {
      _productsInCart.addAll({product: 1});
    }
  }

  void removeProduct(ProductModel product) {
    if (_productsInCart.containsKey(product)) {
      _productsInCart[product] = (_productsInCart[product] ?? 1) - 1;
      if (_productsInCart[product]! <= 0) {
        _productsInCart.remove(product);
      }
    }
  }

  void clearCart() {
    _productsInCart.clear();
  }

  int getCount(ProductModel product) {
    if (_productsInCart.containsKey(product)) {
      return _productsInCart[product]!;
    } else {
      return 0;
    }
  }

  Map<ProductModel, int> getProducts() {
    return _productsInCart;
  }

  bool emptyCart() {
    return _productsInCart.isEmpty;
  }

  Map<String, int> getIdAndCount() {
    Map<String, int> productsAndQuantity = {};
    _productsInCart.forEach((key, value) {
      final int id = key.id;
      productsAndQuantity['$id'] = value;
    });
    return productsAndQuantity;
  }
}
