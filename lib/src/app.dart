import 'package:coffee_shop/src/common/network/repositories/coffee_shop_repository.dart';
import 'package:coffee_shop/src/features/cart/bloc/product_cart_bloc.dart';
import 'package:coffee_shop/src/features/cart/data/product_cart.dart';
import 'package:coffee_shop/src/features/menu/bloc/loading_bloc.dart';
import 'package:coffee_shop/src/features/menu/models/mock_currency.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/menu_screen.dart';
import 'package:coffee_shop/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CoffeeShopApp extends StatefulWidget {
  const CoffeeShopApp({super.key});

  @override
  State<CoffeeShopApp> createState() => _CoffeeShopAppState();
}

class _CoffeeShopAppState extends State<CoffeeShopApp> {
  static CoffeeShopRepository coffeeAPI = CoffeeShopRepository();
  ProductCart productsInCart = ProductCart();
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
        theme: theme,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductCartBloc(productsInCart, 0, currency),
            ),
            BlocProvider(
              create: (context) => LoadingBloc(coffeeAPI),
            ),
          ],
          child: const MenuScreen(),
        ));
  }
}
