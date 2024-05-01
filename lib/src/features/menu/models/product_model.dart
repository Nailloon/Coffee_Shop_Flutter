class ProductModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final Map<String, double> prices;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.prices,
  });
}
