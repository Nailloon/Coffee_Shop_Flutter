import 'dart:convert';

class ProductData {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final Map<String, double> prices;

  ProductData({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.prices,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    Map<String, double> pricesMap = {};
    if (json['prices'] is String) {
      List<Map<String, dynamic>> formattedPrices = [];
      var prices = jsonDecode(json['prices']);
      prices.forEach((key, value) {
        formattedPrices
            .add({"currency": key.toString(), "value": value.toString()});
      });
      json['prices'] = formattedPrices;
    }
    for (var price in json['prices']) {
      pricesMap[price['currency']] = double.parse(price['value']);
    }
    return ProductData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      prices: pricesMap,
    );
  }
}
