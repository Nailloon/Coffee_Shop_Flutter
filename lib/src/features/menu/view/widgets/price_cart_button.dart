import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PriceCartButton extends StatefulWidget {
  final double price;
  final String currency;
  final double width;

  const PriceCartButton({super.key, required this.price, required this.currency, required this.width});

  @override
  _PriceCartButtonState createState() => _PriceCartButtonState();
}

class _PriceCartButtonState extends State<PriceCartButton> {
  int quantity = 0;
  bool showQuantityButtons = false;

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = 24.0;
    final double buttonWidth = (widget.width - 8*2) / 6;
    return InkWell(
      onTap: () {
        setState(() {
          if (!showQuantityButtons) {
            showQuantityButtons = true;
            quantity++;
          }
        });
      },
      child: showQuantityButtons
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (quantity > 0) {
                            quantity--;
                          }
                          if (quantity == 0) {
                            showQuantityButtons = false;
                          }
                        });
                      },
                      child: Icon(Icons.remove, size: buttonHeight, color: AppColors.white),
                    ),
                  ),
                ),
                DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 12.0, color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (quantity < 10) {
                            quantity++;
                          }
                        });
                      },
                      child: Icon(Icons.add, size: buttonHeight, color: AppColors.white,),
                    ),
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                width: (widget.width)/3,
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
                          quantity == 0 ? "${widget.price} ${widget.currency}" : quantity.toString(),
                          style: TextStyle(fontSize: 12.0, color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}