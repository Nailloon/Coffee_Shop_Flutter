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
    return BlocConsumer<LoadingBloc, LoadingState>(
      builder: (context, state) {
        if (state is LoadingCompleted) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
          );
        } else {
          return Container();
        }
      },
      listener: (BuildContext context, LoadingState state) {},
    );
  }
}
