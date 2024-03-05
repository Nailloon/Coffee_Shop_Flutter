import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatefulWidget {
  final String text;

  const CategoryChip({Key? key, required this.text}) : super(key: key);

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: active ? AppColors.white : AppColors.blue,
      side: BorderSide.none,
      label: const Text('Черный кофе'),
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelStyle: TextStyle(
        color: active ? AppColors.realBlack : AppColors.white,
      ),
      onPressed: () {
        setState(() {
          active = !active;
        });
      },
    );
  }
}
