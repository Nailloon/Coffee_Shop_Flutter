import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/price_cart_button.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:coffee_shop/src/theme/image_sources.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductData product;
  final String currency;

  const ProductCard({
    super.key,
    required this.product,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = product.imageUrl;
    double? price = product.prices[currency];
    if (price == null) {
    throw Exception('Price is null for the specified currency');
  }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  ImageSources.placeholder,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  height: 100.0,
                );
              },
              width: double.infinity,
              fit: BoxFit.contain,
              height: 100.0,
            ),
            Text(product.name, style: Theme.of(context).textTheme.titleMedium),
            PriceCartButton(price: price, currency: currency),
          ],
        ),
      ),
    );
  }
}
