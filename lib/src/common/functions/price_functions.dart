import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:coffee_shop/src/features/menu/models/mock_currency.dart';

String formatPrice(double price) {
  if (price % 1 == 0) {
    return price.toInt().toString();
  } else {
    return price.toStringAsFixed(2);
  }
}

String getCurrencySymbol(String currency) {
  final currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'RUB': '₽',
  };

  return currencySymbols[currency] ?? currency;
}

double priceExist(ProductData product) {
  if (product.prices[currency] != null) {
    return product.prices[currency]!;
  } else {
    throw Exception('No price for this currency');
  }
}
