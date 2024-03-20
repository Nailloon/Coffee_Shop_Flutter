import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/product_card.dart';
import 'package:flutter/material.dart';

class CategoryGridView extends StatelessWidget {
  final CategoryData category;
  final String currency;

  const CategoryGridView({Key? key, required this.category, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 190,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: category.products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: category.products[index],
          currency: currency,
        );
      },
    );
  }
}
