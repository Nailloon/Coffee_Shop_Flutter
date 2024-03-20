import 'package:coffee_shop/src/common/network/repositories/coffee_shop_repository.dart';
import 'package:coffee_shop/src/features/menu/data/category_data.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/menu_screen.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:coffee_shop/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CoffeeShopApp extends StatefulWidget {
  const CoffeeShopApp({super.key});

  @override
  State<CoffeeShopApp> createState() => _CoffeeShopAppState();
}

class _CoffeeShopAppState extends State<CoffeeShopApp> {
  CoffeeShopRepository coffeeAPI = CoffeeShopRepository();
  late Future<List<CategoryData>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories= coffeeAPI.fetchAnyProducts(12);
    coffeeAPI.fetchProductByID(789);
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
      home: FutureBuilder<List<CategoryData>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MenuScreen(allCategories: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const ColoredBox(
                color: AppColors.white,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.blue, ),
                ),
              );
            },
          ),
          );
  }
}
