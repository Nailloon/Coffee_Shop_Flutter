import 'dart:async';
import 'dart:developer';

import 'package:coffee_shop/src/app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() => runApp(const CoffeeShopApp()), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
