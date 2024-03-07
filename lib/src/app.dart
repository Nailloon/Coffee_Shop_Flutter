import 'package:coffee_shop/src/features/menu/data/categoryDTO.dart';
import 'package:coffee_shop/src/features/menu/data/productDTO.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_header.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/category_slivergrid.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/chips_row.dart';
import 'package:coffee_shop/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

 ProductDTO product = ProductDTO(name: 'Espresso', price: 2.50, currency: 'руб', imageUrl: 'https://example.com/espresso.jpg');

  ProductDTO product1 = ProductDTO(name: 'Espresso', price: 2.50, currency: 'руб', imageUrl: 'https://example.com/espresso.jpg');
  ProductDTO product2 = ProductDTO(name: 'Latte', price: 3.00, currency: 'руб', imageUrl: 'https://example.com/latte.jpg');
  ProductDTO product3 = ProductDTO(name: 'Олеато', price: 139, currency: 'руб', imageUrl: 'oleato.png');
  CategoryDTO category = CategoryDTO(name: 'Черный кофе', products: [product3, product2, product3,product3, product2, product3,]);
  CategoryDTO category1 = CategoryDTO(name: 'Кофе с молоком', products: [product1, product2, product1, product, product3, product2, product3,]);
  CategoryDTO category2 = CategoryDTO(name: 'Coffeeeeeeeeeeeee2', products: [product1, product2]);
  var categories1 = [category, category1, category2];

class CoffeeShopApp extends StatefulWidget {
  const CoffeeShopApp({Key? key}) : super(key: key);

  @override
  _CoffeeShopAppState createState() => _CoffeeShopAppState();
}

class _CoffeeShopAppState extends State<CoffeeShopApp> {
  final ScrollController _scrollController = ScrollController();

  List<GlobalKey> _categoryKeys = [];

  @override
  void initState() {
    super.initState();
    _categoryKeys = List.generate(categories1.length, (index) => GlobalKey());
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
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(flexibleSpace: CategoryChipsRow(categories: categories1, categoryKeys: _categoryKeys), pinned: true, backgroundColor: Colors.white),
                for (int i = 0; i < categories1.length; i++)
                ...[
                  SliverToBoxAdapter(
                    child: CategoryHeader(category: categories1[i], key: _categoryKeys[i]),
                  ),
                  CategorySliverGrid(category: categories1[i]),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
