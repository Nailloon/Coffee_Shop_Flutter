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
