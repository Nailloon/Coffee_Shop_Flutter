import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:coffee_shop/src/features/menu/data/productDTO.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CategorySliverGrid extends StatelessWidget {
  final CategoryDTO category;

  const CategorySliverGrid({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardPadding = 8.0;
    double maxCardWidth = (screenWidth - 2.0 * cardPadding);

    return SliverGrid(
      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 175, crossAxisSpacing: 8, mainAxisSpacing: 8),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          ProductDTO product = category.products[index];
          return ProductCard(
            name: product.name,
            price: product.price,
            currency: product.currency,
            filename: product.imageUrl,
            maxCardWidth: maxCardWidth,
          );
        },
        childCount: category.products.length,
      ),
    );
  }
}