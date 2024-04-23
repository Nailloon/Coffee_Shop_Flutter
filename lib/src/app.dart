import 'package:coffee_shop/src/common/network/data_sources/category_data_source/network_category_data_source.dart';
import 'package:coffee_shop/src/common/network/data_sources/locations_data_source/locations_data_source.dart';
import 'package:coffee_shop/src/common/network/data_sources/order_data_source/order_data_source.dart';
import 'package:coffee_shop/src/common/network/data_sources/products_data_source/network_products_data_source.dart';
import 'package:coffee_shop/src/common/network/repositories/category_repository/category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/category_repository/interface_category_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/locations_repository/interface_location_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/locations_repository/location_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository/interface_order_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/order_repository/order_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/interface_products_repository.dart';
import 'package:coffee_shop/src/common/network/repositories/products_repository/products_repository.dart';
import 'package:coffee_shop/src/features/cart/bloc/product_cart_bloc.dart';
import 'package:coffee_shop/src/features/cart/data/product_cart.dart';
import 'package:coffee_shop/src/features/database/data_source/savable_category_data_source.dart';
import 'package:coffee_shop/src/features/database/data_source/savable_locations_data_source.dart';
import 'package:coffee_shop/src/features/database/data_source/savable_products_data_source.dart';
import 'package:coffee_shop/src/features/database/database/coffee_database.dart';
import 'package:coffee_shop/src/features/map/bloc/map_bloc.dart';
import 'package:coffee_shop/src/features/menu/bloc/loading_bloc.dart';
import 'package:coffee_shop/src/features/menu/models/category_model.dart';
import 'package:coffee_shop/src/features/menu/models/mock_currency.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/menu_screen.dart';
import 'package:coffee_shop/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

class CoffeeShopApp extends StatefulWidget {
  const CoffeeShopApp({super.key});

  @override
  State<CoffeeShopApp> createState() => _CoffeeShopAppState();
}

class _CoffeeShopAppState extends State<CoffeeShopApp> {
  final AppDatabase database = AppDatabase();
  final http.Client client = http.Client();
  ProductCart productsInCart = ProductCart();
  List<CategoryModel> categoriesForApp = [];
  Map<int, List<dynamic>> categoryEnd = {};

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
        onGenerateTitle: (context) => AppLocalizations.of(context).title,
        theme: theme,
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<IProductRepository>(
                create: (context) => ProductRepository(
                    NetworkProductsDataSource(client),
                    SavableProductsDataSource(database))),
            RepositoryProvider<ICategoryRepository>(
                create: (context) => CategoryRepository(
                    NetworkCategoryDataSource(client),
                    SavableCategoryDataSource(database))),
            RepositoryProvider<IOrderRepository>(
                create: (context) => OrderRepository(OrderDataSource(client))),
            RepositoryProvider<ILocationRepository>(
                create: (context) => LocationRepository(
                    LocationsDataSource(client: client),
                    SavableLocationsDataSource(database)))
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProductCartBloc(productsInCart, 0,
                    currency, context.read<IOrderRepository>()),
              ),
              BlocProvider(
                create: (context) => LoadingBloc(
                    context.read<ICategoryRepository>(),
                    context.read<IProductRepository>(),
                    categoriesForApp,
                    categoryEnd),
              ),
              BlocProvider(
                  create: (context) =>
                      MapBloc(context.read<ILocationRepository>(), [], null))
            ],
            child: const MenuScreen(),
          ),
        ));
  }
}
