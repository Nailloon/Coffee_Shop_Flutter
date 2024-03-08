import 'package:coffee_shop/src/features/menu/data/productDTO.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/price_cart_button.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductDTO product;
  final double maxCardWidth;
  
  const ProductCard({Key? key, required this.product, required this.maxCardWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filename = product.imageUrl;
    String imageUrl = 'assets/images/$filename';
    double imageWidth = maxCardWidth;
    double horizontalPadding = 32;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0,),
        child: SizedBox(
          width: maxCardWidth,
          child: Column(
            children: [
              FutureBuilder<bool>(
                future: doesImageExist(imageUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return Image.asset(imageUrl, width: imageWidth, fit: BoxFit.contain, height: 100.0);
                  } else {
                    return Image.asset('assets/images/emptyCard.png', width: imageWidth, fit: BoxFit.contain, height: 100.0);
                  }
                },
              ),
              Text(product.name, style: TextStyle(fontSize: 16.0)),
              PriceCartButton(price: product.price, currency: product.currency, width: maxCardWidth-horizontalPadding*2),
            ],
          ),
          ),
      ),
    );
  }


  Future<bool> doesImageExist(String imageUrl) async {
    try {
      await rootBundle.load(imageUrl);
      return true;
    } catch (e) {
      return false;
    }
  }
}