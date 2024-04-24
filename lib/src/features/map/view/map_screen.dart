import 'dart:async';

import 'package:coffee_shop/src/features/map/bloc/map_bloc.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:coffee_shop/src/features/map/view/widgets/map_bottomsheet.dart';
import 'package:coffee_shop/src/features/map/view/widgets/maps_locations_button.dart';
import 'package:coffee_shop/src/features/map/view/widgets/return_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
void initState() {
 super.initState();
 LocationModel currentLocation = context.read<MapBloc>().state.current!;
 _initPermission(currentLocation).ignore();
}
  final mapControllerCompleter = Completer<YandexMapController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return YandexMap(
              onMapCreated: (controller) {
                mapControllerCompleter.complete(controller);
              },
              mapObjects: _getPlacemarkObjects(state.locations),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [ReturnButton(), Spacer(), MapsLocationsButton()],
          ),
        ),
      ),
    );
  }

  List<PlacemarkMapObject> _getPlacemarkObjects(List<LocationModel> locations) {
    return locations
        .map(
          (point) => PlacemarkMapObject(
            onTap: (_, __) {
              _moveToCurrentLocation(point);
              showModalBottomSheet(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<MapBloc>(),
                  child: MapBottomSheet(location: point),
                ),
              );
            },
            mapId: MapObjectId('MapObject ${point.address}'),
            point: Point(latitude: point.latitude, longitude: point.longitude),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                    'assets/images/map_point.png',
                  ),
                  scale: 0.1,
                  anchor: const Offset(0.5, 1)),
            ),
          ),
        )
        .toList();
  }
  Future<void> _initPermission(LocationModel location) async {
 await _fetchCurrentLocation(location);
}

Future<void> _fetchCurrentLocation(LocationModel current) async {
  LocationModel location;
 const defLocation = LocationModel(address: 'Omsk', latitude: 54.99244, longitude: 73.36859);
 try {
   location = await _getCurrentPosition();
 } catch (_) {
  debugPrint('Uzuzuzuuz');
   location = current;
 }
 _moveToCurrentLocation(location);
}
  Future<void> _moveToCurrentLocation(
    LocationModel location,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation:
          const MapAnimation(type: MapAnimationType.linear, duration: 0.6),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: location.latitude,
            longitude: location.longitude,
          ),
          zoom: 14,
        ),
      ),
    );
  }

  Future<LocationModel> _getCurrentPosition() async {
    Geolocator.getCurrentPosition().then((value) {
      return LocationModel(
          address: 'currentPosition',
          latitude: value.latitude,
          longitude: value.longitude);
    }).catchError((_) {
      debugPrint('YAYAYAYAYYA');
    });
    throw Exception('dfnuedfviner');
  }
}
