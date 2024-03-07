import 'package:coffee_shop/src/features/menu/view/widgets/price_cart_button.dart';
import 'package:coffee_shop/src/theme/paddings.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String filename;
  final String name;
  final double price;
  final String currency;
  final double maxCardWidth;
  
  const ProductCard({Key? key, required this.name, required this.price, required this.currency, required this.filename, required this.maxCardWidth}) : super(key: key);

  Widget build(BuildContext context) {
    String imageUrl = 'assets/images/$filename';
    double imageWidth = maxCardWidth;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.amber,
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
              Text(name, style: TextStyle(fontSize: 16.0)),
              PriceCartButton(price: price, currency: currency, width: maxCardWidth-64),
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