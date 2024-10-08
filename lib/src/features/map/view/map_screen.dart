import 'dart:async';

import 'package:coffee_shop/src/features/map/bloc/map_bloc/map_bloc.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:coffee_shop/src/features/map/bloc/permission_bloc/permission_bloc.dart';
import 'package:coffee_shop/src/features/map/view/widgets/map_bottomsheet.dart';
import 'package:coffee_shop/src/features/map/view/widgets/maps_locations_button.dart';
import 'package:coffee_shop/src/features/map/view/widgets/return_button.dart';
import 'package:coffee_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final LocationModel? currentLocation;
  final List<PlacemarkMapObject> points = [];
  final mapControllerCompleter = Completer<YandexMapController>();
  late final YandexMapController _mapController;
  CameraPosition? _userLocation;
  final LocationModel _initialLocation = const LocationModel(address: 'Omsk', latitude: 54.99244, longitude: 73.36859);

  @override
  void initState() {
    super.initState();
    currentLocation = context.read<MapBloc>().state.current;
    context
        .read<PermissionBloc>()
        .add(const IsPermissionGrantedEvent(Permission.locationWhenInUse));
    context.read<MapBloc>().add(LoadLocationsEvent());
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<MapBloc, MapState>(
          listener: (context, state) {
            if (state is MapSuccessLoad) {
              points.addAll(_getPlacemarkObjects(
                  context.read<MapBloc>().state.locations));
            }
          },
          builder: (context, state) {
            return BlocListener<PermissionBloc, PermissionState>(
                listener: (context, state) async {
                  _moveToInitialLocation();
                  if (state is PermissionDenied) {
                    if (currentLocation != null) {
                      _moveToCurrentLocation(currentLocation!);
                    }
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
                            title: Text(AppLocalizations.of(context)
                                .location_permission_text),
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
                                  child: Text(AppLocalizations.of(context)
                                      .cancel_button)),
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
                                  child: Text(AppLocalizations.of(context)
                                      .apply_button))
                            ],
                          );
                        });
                  }
                  if (state is PermissionChanged) {
                    _mapController.toggleUserLayer(visible: true);
                  }
                },
                child: YandexMap(
                    onMapCreated: (controller) async {
                      _mapController = controller;
                      _mapController.toggleUserLayer(visible: true);
                      mapControllerCompleter.complete(controller);
                    },
                    mapObjects: points,
                    onUserLocationAdded: (view) async {
                      _userLocation =
                          await _mapController.getUserCameraPosition();
                      if (_userLocation != null) {
                        await _moveCameraToUser(_userLocation!);
                      }
                      return view.copyWith(
                        pin: view.pin.copyWith(
                          opacity: 1,
                        ),
                      );
                    }));
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
            onTap: (_, __) async {
              _moveToCurrentLocation(point);
              bool? needReturn = await showModalBottomSheet<bool?>(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<MapBloc>(),
                  child: MapBottomSheet(location: point),
                ),
              );
              if (!mounted) return;
              if (needReturn == true) {
                Navigator.pop(context);
              }
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

  Future<void> _moveToInitialLocation() async{
    (await mapControllerCompleter.future).moveCamera(
      animation:
          const MapAnimation(type: MapAnimationType.linear, duration: 0.6),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: _initialLocation.latitude,
            longitude: _initialLocation.longitude,
          ),
          zoom: 11,
        ),
      ),
    );
  }

  Future<void> _moveCameraToUser(CameraPosition camera) async {
    (await mapControllerCompleter.future).moveCamera(
      animation:
          const MapAnimation(type: MapAnimationType.linear, duration: 0.6),
      CameraUpdate.newCameraPosition(camera.copyWith(zoom: 14)),
    );
  }
}
