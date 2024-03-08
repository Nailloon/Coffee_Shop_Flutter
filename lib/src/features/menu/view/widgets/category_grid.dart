import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CategoryGridView extends StatelessWidget {
  final CategoryDTO category;

  const CategoryGridView({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardPadding = 8.0;
    double maxCardWidth = (screenWidth - 2.0 * cardPadding);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 175,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: category.products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: category.products[index],
          maxCardWidth: maxCardWidth,
        );
      },
    );
  }
}