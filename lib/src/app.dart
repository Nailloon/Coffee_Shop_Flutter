import 'package:coffee_shop/src/common/network/repositories/coffee_shop_repository.dart';
import 'package:coffee_shop/src/features/menu/bloc/loading_bloc.dart';
import 'package:coffee_shop/src/features/menu/view/widgets/menu_screen.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
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
  final LoadingBloc _loadingBloc = LoadingBloc(coffeeAPI);

  @override
  void initState() {
    super.initState();
    coffeeAPI.fetchProductByID(id: 789);
    _loadingBloc.add(LoadCategoriesEvent());
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
        home: BlocBuilder<LoadingBloc, LoadingState>(
          bloc: _loadingBloc,
          builder: (context, state) {
            if (state is LoadingCompleted) {
              return MenuScreen(allCategories: state.categories);
            }
            if (state is LoadingFailure) {
              return ColoredBox(
                  color: AppColors.white,
                  child: Center(
                      child: Text(
                          AppLocalizations.of(context)!
                              .error_in_Loading_categories,
                          style: Theme.of(context).textTheme.titleLarge)));
            } else {
              return const ColoredBox(
                  color: AppColors.white,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blue,
                    ),
                  ));
            }
          },
        ));
  }
}
