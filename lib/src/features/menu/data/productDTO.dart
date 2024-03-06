class ProductDTO {
  final String name;
  final double price;
  final String imageUrl;
  final String currency;

  ProductDTO({required this.name, required this.price, required this.imageUrl, required this.currency});

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      name: json['name'],
      price: json['price'],
      currency: json['currency'],
      imageUrl: json['imageUrl'],
    );
  }
}