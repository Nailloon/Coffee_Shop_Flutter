import 'package:coffee_shop/src/theme/paddings.dart';
import 'package:flutter/services.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String filename;
  final String name;
  final double price;
  
  const ProductCard({Key? key, required this.name, required this.price, required this.filename}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'assets/images/$filename';
    double imageWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
      child: SizedBox(
        width: 200,
        child: ColoredBox(
          color: AppColors.blue,
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
                  Text(price.toString()),
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