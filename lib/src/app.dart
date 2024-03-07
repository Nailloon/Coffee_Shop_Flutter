import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:coffee_shop/src/features/menu/data/productDTO.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_header.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_slivergrid.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/chips_row.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:coffee_shop/src/theme/paddings.dart';
import 'package:coffee_shop/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

 ProductDTO product = ProductDTO(name: 'Espresso', price: 2.50, currency: 'руб', imageUrl: 'https://example.com/espresso.jpg');

  ProductDTO product1 = ProductDTO(name: 'Espresso', price: 2.50, currency: 'руб', imageUrl: 'https://example.com/espresso.jpg');
  ProductDTO product2 = ProductDTO(name: 'Latte', price: 3.00, currency: 'руб', imageUrl: 'https://example.com/latte.jpg');
  ProductDTO product3 = ProductDTO(name: 'Олеато', price: 139, currency: 'руб', imageUrl: 'oleato.png');
  CategoryDTO category = CategoryDTO(name: 'Черный кофе', products: [product3, product2, product3]);
  CategoryDTO category1 = CategoryDTO(name: 'Кофе с молоком', products: [product1, product2, product1, product]);
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
        body: SafeArea(child: Padding(
          padding: OurPaddings.screenPadding,
          child: CustomScrollView(slivers: [
            SliverAppBar(flexibleSpace: CategoryChipsRow(categories: categories1), pinned: true, backgroundColor: AppColors.white),
              SliverToBoxAdapter(
                  child: CategoryHeader(category: category1,),
                ),
            CategorySliverGrid(category: category1),
                SliverToBoxAdapter(
                  child: CategoryHeader(category: category,),
                ),
            CategorySliverGrid(category: category),
            SliverToBoxAdapter(
                  child: CategoryHeader(category: category1,),
                ),
            CategorySliverGrid(category: category1),
                SliverToBoxAdapter(
                  child: CategoryHeader(category: category,),
                ),
            CategorySliverGrid(category: category),
              ],
            ),
        ),)
        ),
    );
  }
}