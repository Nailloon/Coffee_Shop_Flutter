import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PriceButton extends StatelessWidget {
  final double price;
  final String currency;
  const PriceButton({super.key, required this.price, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: double.infinity,
        height: 24.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${formatPrice(price)} $currency",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String formatPrice(double price) {
  if (price % 1 == 0) {
    return price.toInt().toString();
  } else {
    return price.toStringAsFixed(2);
  }
}
