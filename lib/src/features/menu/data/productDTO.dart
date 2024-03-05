class ProductDTO {
  final String name;
  final double price;
  final String imageUrl;

  ProductDTO({required this.name, required this.price, required this.imageUrl});

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}