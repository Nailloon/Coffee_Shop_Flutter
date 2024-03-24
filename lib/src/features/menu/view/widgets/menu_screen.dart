import 'package:coffee_shop/src/features/cart/bloc/product_cart_bloc.dart';
import 'package:coffee_shop/src/features/cart/data/product_cart.dart';
import 'package:coffee_shop/src/features/cart/view/widgets/cart_button.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/category_appbar/category_chip.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/category_grid/category_grid.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/category_grid/category_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  final List<CategoryData> allCategories;

  const MenuScreen({super.key, required this.allCategories});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Map<String, GlobalKey> _categoryKeys;
  final ItemScrollController _menuController = ItemScrollController();
  final ItemScrollController _appBarController = ItemScrollController();
  final ItemPositionsListener _itemListener = ItemPositionsListener.create();

  int current = 0;
  bool inProgress = false;
  bool scrolledToBottom = false;
  String currency = 'RUB';
  ProductCart productsInCart = ProductCart();

  @override
  void initState() {
    super.initState();

    _categoryKeys = {
      for (var category in widget.allCategories) category.name: GlobalKey()
    };

    _itemListener.itemPositions.addListener(() {
      final firstVisibleIndex = _itemListener.itemPositions.value.isNotEmpty
          ? _itemListener.itemPositions.value.first.index
          : current;

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
                        if (index < widget.allCategories.length - 1) {
                          appBarScrollToCategory(index);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          body: BlocProvider(
            create: (context) => ProductCartBloc(productsInCart, 0, currency),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<ProductCartBloc, ProductCartState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                        ScrollablePositionedList.builder(
                          itemScrollController: _menuController,
                          itemPositionsListener: _itemListener,
                          itemBuilder: (context, index) {
                            final category = widget.allCategories[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CategoryHeader(
                                  key: _categoryKeys[category.id.toString()],
                                  category: category,
                                ),
                                CategoryGridView(
                                  category: category,
                                  currency: currency,
                                ),
                              ],
                            );
                          },
                          itemCount: widget.allCategories.length,
                        ),
                        if (state is ProductCartChanged)
                          Positioned(
                              bottom: 16.0,
                              right: 0.0,
                              child: SizedBox(
                                  width: 100,
                                  child: PriceButtonWithIcon(
                                      price: state.price, currency: currency)))
                      ],
                    );
                  },
                )),
          )),
    );
  }
}
