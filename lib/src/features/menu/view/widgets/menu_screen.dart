import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_chip.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_header.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  final List <CategoryDTO> allCategories;
  
  const MenuScreen({super.key, required this.allCategories});
  
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  late Map<String, GlobalKey> categoryKeys;
  late String selectedCategoryName;
  final ItemScrollController _menuController = ItemScrollController();
  final ItemScrollController _appBarController = ItemScrollController();
  late ItemPositionsListener itemListener;
  int current = 0;
  bool inProgress = false;
  bool scrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    itemListener = ItemPositionsListener.create();

    categoryKeys = {
      for (var category in widget.allCategories) category.name: GlobalKey()
    };

    itemListener.itemPositions.addListener(() {
      final fullVisible = itemListener.itemPositions.value
          .where((item) {
            return item.itemLeadingEdge >= 0;
          })
          .map((item) => item.index)
          .toList();

      if (((fullVisible[0] != current) && inProgress != true) &&
          scrolledToBottom == false) {
        setCurrent(fullVisible[0]);
        appBarScrollToCategory(fullVisible[0]);
      }
    });
  }

  void setCurrent(int newCurrent) {
    setState(() {
      current = newCurrent;
    });
  }

  menuScrollToCategory(int ind) async {
    inProgress = true;
    _menuController.scrollTo(
        index: ind, duration: const Duration(milliseconds: 400));
    await Future.delayed(const Duration(milliseconds: 400));
    inProgress = false;
  }

  appBarScrollToCategory(int ind) async {
    _appBarController.scrollTo(
      curve: Curves.easeOut,
      opacityAnimationWeights: [20,20,60],
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
                shrinkWrap: true,
                itemScrollController: _appBarController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.allCategories.length,
                itemBuilder: (context, index) {
                  final category = widget.allCategories[index];
                  return CategoryChip(text: category.name, isSelected: index==current, onSelected: () {
                        setCurrent(index);
                        menuScrollToCategory(index);
                        appBarScrollToCategory(index);
                      },);
                },
              ),
            ),
          ),
        ),
          body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ScrollablePositionedList.builder(
            shrinkWrap: true,
            itemScrollController: _menuController,
            itemPositionsListener: itemListener,
            itemBuilder: (context, index) {
              final category = widget.allCategories[index];
              return Column(
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