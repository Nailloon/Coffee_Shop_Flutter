import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: YandexMap(
       onMapCreated: (controller) {
         mapControllerCompleter.complete(controller);
       },
     ),);
  }
}