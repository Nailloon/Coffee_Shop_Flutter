import 'package:flutter/material.dart';

class PriceCartButton extends StatefulWidget {
  final double price;
  final String currency;

  PriceCartButton({required this.price, required this.currency});

  @override
  _PriceCartButtonState createState() => _PriceCartButtonState();
}

class _PriceCartButtonState extends State<PriceCartButton> {
  int quantity = 0;
  bool showQuantityButtons = false;
  final double buttonHeight = 24.0;
  final double buttonWidth = 56.0;

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(4.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
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
                      child: Icon(Icons.remove, size: buttonHeight),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.green,
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
                      child: Icon(Icons.add, size: buttonHeight),
                    ),
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: 116.0,
                height: 24.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          quantity == 0 ? "${widget.price} ${widget.currency}" : quantity.toString(),
                          style: TextStyle(fontSize: 12.0),
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