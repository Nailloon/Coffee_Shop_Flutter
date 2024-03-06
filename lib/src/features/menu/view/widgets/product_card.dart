import 'package:coffee_shop/src/features/menu/view/widgets/price_cart_button.dart';
import 'package:coffee_shop/src/theme/paddings.dart';
import 'package:flutter/services.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String filename;
  final String name;
  final double price;
  final String currency;
  
  const ProductCard({Key? key, required this.name, required this.price, required this.currency, required this.filename}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'assets/images/$filename';
    double imageWidth = MediaQuery.of(context).size.width;

    return Card(
      child: SizedBox(
        width: 200,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: OurPaddings.screenPadding,
            child: Center(
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
                  Text(name),
                  PriceCartButton(price: price, currency: currency),
                ],
              ),
            ),
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