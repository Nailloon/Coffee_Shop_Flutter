import 'package:coffee_shop/src/features/menu/bloc/loading_bloc.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/product_card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryGridView extends StatelessWidget {
  final CategoryData category;
  final String currency;

  const CategoryGridView(
      {super.key, required this.category, required this.currency});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        if (state is LoadingCompleted) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (scrollInfo) {
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      !state.loadingCompleteForCategory[category.id]![0]
                  ? context
                      .read<LoadingBloc>()
                      .add(LoadMoreProductsEvent(category))
                  : null;
              return false;
            },
            child: GridView.builder(
              shrinkWrap: true,
              physics: PageScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              controller: ScrollController(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 190,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: category.products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: category.products[index],
                  currency: currency,
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
