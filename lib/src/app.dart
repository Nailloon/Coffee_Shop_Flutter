import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:coffee_shop/src/features/menu/data/productDTO.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/chips_row.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/product_card.dart';
import 'package:coffee_shop/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

 ProductDTO product = ProductDTO(name: 'Espresso', price: 2.50, currency: 'руб', imageUrl: 'https://example.com/espresso.jpg');

  ProductDTO product1 = ProductDTO(name: 'Espresso', price: 2.50, currency: 'руб', imageUrl: 'https://example.com/espresso.jpg');
  ProductDTO product2 = ProductDTO(name: 'Latte', price: 3.00, currency: 'руб', imageUrl: 'https://example.com/latte.jpg');
  CategoryDTO category = CategoryDTO(name: 'Coffeeeeeeeeeeeeeeee', products: [product1, product2]);
  CategoryDTO category1 = CategoryDTO(name: 'Coffeeeeeeeeee1', products: [product1, product2]);
  CategoryDTO category2 = CategoryDTO(name: 'Coffeeeeeeeeeeeee2', products: [product1, product2]);
  var categories1 = [category, category1, category2];

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

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
      home: Scaffold(
        body: Column(
        children: [
          CategoryChipsRow(categories: categories1),
          SizedBox(height: 100.0,),
          SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:Row(children: [ProductCard(name: 'Олеато', price: 130.0,currency: 'руб',  filename: "oleato.png"),
          ProductCard(name: 'Олеато', price: 130.0,currency: 'руб', filename: "oleato1.png"), ProductCard(name: 'Олеато', price: 130.0,currency: 'руб', filename: "oleato1.png")  ],))
          
        ],
      )),
    );
  }
}