import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatefulWidget {
  final String text;
  final bool active;

  const CategoryChip({Key? key, required this.text, this.active = false}) : super(key: key);

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  late bool _active;

  @override
  void initState() {
    super.initState();
    _active = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: _active ? AppColors.white : AppColors.blue,
      side: BorderSide.none,
      label: Text(widget.text),
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      labelStyle: TextStyle(
        color: _active ? AppColors.realBlack : AppColors.white,
      ),
      onPressed: () {
        setState(() {
          _active = !_active;
        });
        
        final categoryHeaderKey = GlobalKey();
        Future.delayed(Duration.zero, () {
          final context = categoryHeaderKey.currentContext;
          if (context != null) {
            Scrollable.ensureVisible(context);
          }
        });
      },
    );
  }
}