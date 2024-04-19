import 'package:coffee_shop/src/features/menu/models/product_model.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/product_card/price_cart_button.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:coffee_shop/src/theme/image_sources.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final String currency;

  const ProductCard({
    super.key,
    required this.product,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl = product.imageUrl;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => Image.asset(
                ImageSources.placeholder,
                width: double.infinity,
                fit: BoxFit.contain,
                height: 100.0,
              ),
              width: double.infinity,
              fit: BoxFit.contain,
              height: 100.0,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: AppColors.blue,
              ),
            ),
            Text(product.name, style: Theme.of(context).textTheme.titleMedium),
            PriceCartButton(product: product),
          ],
        ),
      ),
    );
  }
}
