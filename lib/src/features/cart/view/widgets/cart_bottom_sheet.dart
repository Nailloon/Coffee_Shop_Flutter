import 'package:coffee_shop/src/common/functions/price_functions.dart';
import 'package:coffee_shop/src/features/cart/bloc/product_cart_bloc.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:coffee_shop/src/theme/image_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartBottomSheet extends StatelessWidget {
  final String currency;
  const CartBottomSheet({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCartBloc, ProductCartState>(
      listener: (context, state) {
        if (state is ClearProductCart || state is ReturnToMainScreen) {
          Navigator.pop(context);
        }
      },
      child: BottomSheet(
        animationController: AnimationController(
          vsync: Scaffold.of(context),
          duration: const Duration(milliseconds: 300),
        ),
        enableDrag: true,
        showDragHandle: true,
        backgroundColor: AppColors.white,
        onClosing: () {
          context.read<ProductCartBloc>().add(ReturnToMainScreen());
          Navigator.pop(context);
        },
        builder: (BuildContext context) {
          return BlocBuilder<ProductCartBloc, ProductCartState>(
            builder: (context, state) {
              if (state is AllProductsInCart) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cart.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                ListTile(
                                    title: Text(
                                      AppLocalizations.of(context)!.your_order,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    trailing: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: InkWell(
                                          child: const Icon(
                                            Icons.delete_outline,
                                            color: AppColors.greyIcon,
                                          ),
                                          onTap: () {
                                            context
                                                .read<ProductCartBloc>()
                                                .add(ClearProductCart());
                                            Navigator.pop(context);
                                          }),
                                    )),
                                const Divider(endIndent: 8.0, indent: 8.0),
                              ],
                            );
                          }
                          ProductData product = state.cart[index - 1];

                          return ListTile(
                            leading: Image.network(
                              product.imageUrl,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  ImageSources.placeholder,
                                  width: 55,
                                  fit: BoxFit.cover,
                                  height: 55,
                                );
                              },
                              width: 55,
                              fit: BoxFit.contain,
                              height: 55,
                            ),
                            title: Text(
                              product.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            trailing: Text(
                              "${formatPrice(product.prices[currency]!)} ${getCurrencySymbol(currency)}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: InkWell(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.make_order,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
