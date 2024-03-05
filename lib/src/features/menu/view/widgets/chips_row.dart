import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:flutter/material.dart';
import 'category_chip.dart';

class CategoryChipsRow extends StatelessWidget {
  final List<CategoryDTO> categories;

  const CategoryChipsRow({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Row(
            children: [
                    CategoryChip(text: category.name),
                    const SizedBox(width: 8.0),
            ],
          );
        }).toList(),
      ),
    );
  }
}