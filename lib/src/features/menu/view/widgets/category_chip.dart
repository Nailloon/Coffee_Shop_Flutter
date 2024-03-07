import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onSelected;
  final Key key;

  CategoryChip({Key? key, required this.text, required this.active, required this.onSelected})
      : this.key = key ?? UniqueKey(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: active ? AppColors.white : AppColors.blue,
      side: BorderSide.none,
      label: Text(text),
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelStyle: TextStyle(
        color: active ? AppColors.realBlack : AppColors.white,
      ),
      onPressed: onSelected,
    );
  }
}