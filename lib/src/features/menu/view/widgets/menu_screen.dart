import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_chip.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_header.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  final List<CategoryData> allCategories;

  const MenuScreen({super.key, required this.allCategories});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Map<String, GlobalKey> categoryKeys;
  final ItemScrollController _menuController = ItemScrollController();
  final ItemScrollController _appBarController = ItemScrollController();
  final ItemPositionsListener itemListener = ItemPositionsListener.create();
  int current = 0;
  bool inProgress = false;
  bool scrolledToBottom = false;

  @override
  void initState() {
    super.initState();

    categoryKeys = {
      for (var category in widget.allCategories) category.name: GlobalKey()
    };

    itemListener.itemPositions.addListener(() {
      final firstVisibleIndex = itemListener.itemPositions.value
          .firstWhere((item) => item.itemLeadingEdge >= 0)
          .index;

      if (firstVisibleIndex != current && !inProgress) {
        setCurrent(firstVisibleIndex);
        appBarScrollToCategory(firstVisibleIndex);
      }
    });
  }

  void setCurrent(int newCurrent) {
    setState(() {
      current = newCurrent;
    });
  }

  void menuScrollToCategory(int ind) async {
    inProgress = true;
    _menuController.scrollTo(
        index: ind, duration: const Duration(milliseconds: 400));
    await Future.delayed(const Duration(milliseconds: 400));
    inProgress = false;
  }

  void appBarScrollToCategory(int ind) async {
    _appBarController.scrollTo(
        curve: Curves.easeOut,
        opacityAnimationWeights: [20, 20, 60],
        index: ind,
        duration: const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: PreferredSize(
            preferredSize: const Size.fromHeight((40)),
            child: SizedBox(
              height: 40,
              child: ScrollablePositionedList.builder(
                itemScrollController: _appBarController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.allCategories.length,
                itemBuilder: (context, index) {
                  final category = widget.allCategories[index];
                  return CategoryChip(
                    text: category.name,
                    isSelected: index == current,
                    onSelected: () {
                      setCurrent(index);
                      menuScrollToCategory(index);
                      appBarScrollToCategory(index);
                    },
                  );
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ScrollablePositionedList.builder(
            itemScrollController: _menuController,
            itemPositionsListener: itemListener,
            itemBuilder: (context, index) {
              final category = widget.allCategories[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryHeader(
                    key: categoryKeys[category.name],
                    category: category,
                  ),
                  CategoryGridView(category: category)
                ],
              );
            },
            itemCount: widget.allCategories.length,
          ),
        ),
      ),
    );
  }
}
