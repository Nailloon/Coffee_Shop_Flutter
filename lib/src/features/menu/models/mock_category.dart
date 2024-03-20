import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/models/mock_product.dart';

CategoryData category = CategoryData(id: 1, name: 'Черный кофе', products: [product1, product4,]);
CategoryData category1 = CategoryData(id: 2, name: 'Кофе с молоком', products: [product2, product, product3, product2, product3,]);
CategoryData category2 = CategoryData(id:3, name: 'Остальное', products: [product, product]);
var categories1 = [category, category1, category2];