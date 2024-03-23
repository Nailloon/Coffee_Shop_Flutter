import 'package:coffee_shop/src/features/menu/data/product_data.dart';

class ProductCart {
  final List<ProductData> _productsInCart = [];

  List<ProductData> get products => _productsInCart;

  void addProduct(ProductData product) {
    _productsInCart.add(product);
  }

  List<ProductData> getProducts() {
    return List<ProductData>.from(_productsInCart);
  }

  void removeProduct(ProductData product) {
    _productsInCart.remove(product);
  }
}