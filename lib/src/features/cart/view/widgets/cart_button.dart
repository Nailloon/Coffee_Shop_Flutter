import 'package:coffee_shop/src/common/functions/price_functions.dart';
import 'package:coffee_shop/src/features/cart/bloc/product_cart_bloc.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceButtonWithIcon extends StatelessWidget {
  final double price;
  final String currency;
  const PriceButtonWithIcon(
      {super.key, required this.price, required this.currency});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              context
                  .read<ProductCartBloc>()
                  .add(ViewAllProductCart());
            },
            child:Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.local_mall, size: 16.0, color: AppColors.white),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                "${formatPrice(price)} ${getCurrencySymbol(currency)}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          )
        ),
      ),
    );
  }
}
