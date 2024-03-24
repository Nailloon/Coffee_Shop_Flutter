
import 'package:coffee_shop/src/features/menu/view/widgets/components/product_card/price_button.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PriceCartButton extends StatefulWidget {
  final double price;
  final String currency;

  const PriceCartButton(
      {super.key, required this.price, required this.currency});

  @override
  State<PriceCartButton> createState() => _PriceCartButtonState();
}

class _PriceCartButtonState extends State<PriceCartButton> {
  int quantity = 0;
  bool showQuantityButtons = false;

  @override
  Widget build(BuildContext context) {
    const double buttonHeight = 24.0;
    const double buttonWidth = double.infinity;
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
                    padding: const EdgeInsets.only(right: 4.0),
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
                        child: const Icon(Icons.remove,
                            size: buttonHeight, color: AppColors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DecoratedBox(
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
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
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
                        child: const Icon(
                          Icons.add,
                          size: buttonHeight,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : PriceButton(price: widget.price, currency: widget.currency));
  }
}
