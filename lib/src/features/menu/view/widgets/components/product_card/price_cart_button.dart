import 'package:coffee_shop/src/features/cart/bloc/product_cart_bloc.dart';
import 'package:coffee_shop/src/features/menu/data/product_data.dart';
import 'package:coffee_shop/src/features/menu/models/mock_currency.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/components/product_card/price_button.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceCartButton extends StatefulWidget {
  final ProductData product;

  const PriceCartButton({super.key, required this.product});

  @override
  State<PriceCartButton> createState() => _PriceCartButtonState();
}

class _PriceCartButtonState extends State<PriceCartButton> {
  int quantity = 0;
  bool showQuantityButtons = false;

  @override
  Widget build(BuildContext context) {
    double? price = widget.product.prices[currency];
    if (price == null) {
      throw Exception('Price is null for the specified currency');
    }
    const double buttonHeight = 24.0;
    const double buttonWidth = double.infinity;
    return BlocBuilder<ProductCartBloc, ProductCartState>(
      builder: (context, state) {
        return BlocListener<ProductCartBloc, ProductCartState>(
            listener: (context, state) {
              if (state is EmptyProductCart) {
                setState(() {
                  quantity = 0;
                  showQuantityButtons = false;
                });
              }
            },
            child: InkWell(
                onTap: () {
                  setState(() {
                    if (!showQuantityButtons) {
                      showQuantityButtons = true;
                      quantity++;
                      context
                          .read<ProductCartBloc>()
                          .add(AddProductToCart(product: widget.product));
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
                                    context.read<ProductCartBloc>().add(
                                        RemoveProductFromCart(
                                            product: widget.product));
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                                      context.read<ProductCartBloc>().add(
                                          AddProductToCart(
                                              product: widget.product));
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
                    : PriceButton(price: price, currency: currency)));
      },
    );
  }
}
