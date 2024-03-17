class ProductData {
  final String name;
  final double price;
  final String imageUrl;
  final String currency;

  const ProductData(
      {required this.name,
      required this.price,
      required this.imageUrl,
      required this.currency});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      name: json['name'],
      price: json['price'],
      currency: json['currency'],
      imageUrl: json['imageUrl'],
    );
  }
}
