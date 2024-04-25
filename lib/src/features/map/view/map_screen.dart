import 'dart:async';

import 'package:coffee_shop/src/features/map/bloc/map_bloc.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:coffee_shop/src/features/map/permission_bloc.dart/permission_bloc.dart';
import 'package:coffee_shop/src/features/map/view/widgets/map_bottomsheet.dart';
import 'package:coffee_shop/src/features/map/view/widgets/maps_locations_button.dart';
import 'package:coffee_shop/src/features/map/view/widgets/return_button.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
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
    context
        .read<PermissionBloc>()
        .add(const IsPermissionGrantedEvent(Permission.locationWhenInUse));
    _fetchCurrentLocation(currentLocation);
  }

  final mapControllerCompleter = Completer<YandexMapController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return BlocListener<PermissionBloc, PermissionState>(
                listener: (context, state) async {
                  if (state is PermissionDenied) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            backgroundColor: AppColors.white,
                            icon: const Icon(
                              Icons.map_outlined,
                              color: AppColors.realBlack,
                            ),
                            surfaceTintColor: AppColors.realBlack,
                            title: Text('Разрешите доступ к геолокации'),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: [
                              TextButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.blue)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Отменить')),
                              TextButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.blue)),
                                  onPressed: () {
                                    context.read<PermissionBloc>().add(
                                        const RequestPermissionEvent(
                                            Permission.locationWhenInUse));
                                    Navigator.pop(context);
                                  },
                                  child: Text('Разрешить'))
                            ],
                          );
                        });
                  }
                  if (state is PermissionChanged) {
                    _moveToCurrentLocation(await _getGeoPosition());
                  }
                },
                child: YandexMap(
                  onMapCreated: (controller) {
                    mapControllerCompleter.complete(controller);
                  },
                  mapObjects: _getPlacemarkObjects(state.locations),
                ));
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

  Future<void> _fetchCurrentLocation(LocationModel current) async {
    LocationModel location;
    try {
      location = await _getGeoPosition();
    } catch (_) {
      debugPrint('Uzuzuzuuz');
      location = current;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(
    LocationModel location,
  ) async {
    debugPrint('gogogogogo');
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

  Future<LocationModel> _getGeoPosition() async {
    var geoposition = await Geolocator.getCurrentPosition().then((value) =>
        LocationModel(
            address: 'geoposition',
            latitude: value.latitude,
            longitude: value.longitude));
    debugPrint('Geoposition:$geoposition');
    return geoposition;
  }
}
