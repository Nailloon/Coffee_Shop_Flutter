import 'package:coffee_shop/src/common/functions/price_functions.dart';
import 'package:coffee_shop/src/features/cart/bloc/product_cart_bloc.dart';
import 'package:coffee_shop/src/features/cart/view/widgets/cart_bottom_sheet.dart';
import 'package:coffee_shop/src/features/menu/bloc/loading_bloc.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/models/mock_currency.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/category_appbar/category_chip.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/category_grid/category_grid.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/category_grid/category_header.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Map<String, GlobalKey> _categoryKeys;
  final ItemScrollController _menuController = ItemScrollController();
  final ItemScrollController _appBarController = ItemScrollController();
  final ItemPositionsListener _itemListener = ItemPositionsListener.create();
  final List<CategoryData> allCategories= [];

  int current = 0;
  bool inProgress = false;
  bool scrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    context.read<LoadingBloc>().add(LoadCategoriesEvent());

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
      child: BlocBuilder<LoadingBloc, LoadingState>(
        builder: (context, state) {
          if (state is LoadingCompleted) {
            _categoryKeys = {
              for (var category in state.categories) category.name: GlobalKey()
            };
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                surfaceTintColor: Colors.transparent,
                title: PreferredSize(
                  preferredSize: const Size.fromHeight((40)),
                  child: SizedBox(
                    height: 40,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _appBarController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return CategoryChip(
                          text: category.name,
                          isSelected: index == current,
                          onSelected: () {
                            setCurrent(index);
                            menuScrollToCategory(index);
                            if (index < state.categories.length - 1) {
                              appBarScrollToCategory(index);
                            }
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
                    itemPositionsListener: _itemListener,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
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
                    itemCount: state.categories.length,
                  )),
              floatingActionButton:
                  BlocBuilder<ProductCartBloc, ProductCartState>(
                builder: (context, state) {
                  return BlocBuilder<ProductCartBloc, ProductCartState>(
                    builder: (context, state) {
                      if (state is ProductCartChanged) {
                        return SizedBox(
                            width: 120,
                            height: 45,
                            child: FloatingActionButton(
                              onPressed: () {
                                context
                                    .read<ProductCartBloc>()
                                    .add(ViewAllProductCart());
                                showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const CartBottomSheet(
                                      currency: currency,
                                    );
                                  },
                                  enableDrag: true,
                                );
                              },
                              backgroundColor: AppColors.blue,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.shopping_bag_outlined, color: AppColors.white,size: 21.0,),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      "${formatPrice(state.price)} ${getCurrencySymbol(currency)}",
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              ),
            );
          }
          if (state is LoadingFailure) {
            final String exceptionText = state.exception.toString();
            return Text(
              
              AppLocalizations.of(context)!.error_in_Loading_categories+' $exceptionText',
              
            );
          } else {
            return const ColoredBox(
                color: AppColors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue,
                  ),
                ));
          }
        },
      ),
    );
  }
}
