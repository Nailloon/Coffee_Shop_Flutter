import 'dart:async';
import 'dart:developer';
import 'package:coffee_shop/src/features/push_notifications/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:coffee_shop/src/app.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseApi().initNotifictions();
    runApp(const CoffeeShopApp());
  }, (error, stack) async {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
