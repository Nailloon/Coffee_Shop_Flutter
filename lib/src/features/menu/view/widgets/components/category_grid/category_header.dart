import 'package:coffee_shop/src/features/menu/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final CategoryModel category;

  const CategoryHeader({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        category.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
