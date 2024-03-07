
import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final CategoryDTO category;

  const CategoryHeader({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
          Text(
            category.name,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),

    );
  }
}