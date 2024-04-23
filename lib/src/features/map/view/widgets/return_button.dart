import 'package:coffee_shop/src/common/functions/navigation_functions.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
        heroTag: 'return',
        onPressed: () => returnToPreviousScreen(context),
        backgroundColor: AppColors.white,
        child: const Icon(
          Icons.arrow_back,
          size: 20.0,
          color: AppColors.realBlack,
        ));
  }
}
