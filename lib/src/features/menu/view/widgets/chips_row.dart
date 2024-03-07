import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:flutter/material.dart';
import 'category_chip.dart';

class CategoryChipsRow extends StatefulWidget {
  final List<CategoryDTO> categories;
  final List<GlobalKey> categoryKeys;

  const CategoryChipsRow({Key? key, required this.categories, required this.categoryKeys}) : super(key: key);

  @override
  _CategoryChipsRowState createState() => _CategoryChipsRowState();
}

class _CategoryChipsRowState extends State<CategoryChipsRow> {
  late int _activeIndex;

  @override
  void initState() {
    super.initState();
    _activeIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          final category = widget.categories[index];
          return Row(
            children: [
              CategoryChip(
                text: category.name,
                active: index == _activeIndex,
                onSelected: () {
                  setState(() {
                    _activeIndex = index;
                  });
                  
                  Future.delayed(Duration.zero, () {
                    final categoryKey = widget.categoryKeys[index];
                    Scrollable.ensureVisible(categoryKey.currentContext!, alignment: 0.0, duration: Duration(milliseconds: 400));
                  });
                },
              ),
              const SizedBox(width: 8.0),
            ],
          );
        }),
      ),
    );
  }
}
