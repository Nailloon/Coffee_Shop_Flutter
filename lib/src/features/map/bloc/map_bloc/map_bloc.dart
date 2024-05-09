import 'package:coffee_shop/src/common/network/repositories/locations_repository/interface_location_repository.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'map_event.dart';
part 'map_state.dart';

final class MapBloc extends Bloc<MapEvent, MapState> {
  List<LocationModel> locationsForApp;
  LocationModel? currentLocation;
  final ILocationRepository locationRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String prefsCurrent = 'currentLocation';
  final String prefsCurrentLong = 'currentLocationLong';
  final String prefsCurrentLati = 'currentLocationLati';

  MapBloc(this.locationRepository, this.locationsForApp, this.currentLocation)
      : super(MapIdle(locationsForApp, currentLocation)) {
    on<LoadCurrentLocationEvent>(_handleLoadCurrentLocationEvent);
    on<LoadLocationsEvent>(_hanleLoadLocationsEvent);
    on<ChooseCurrentLocationEvent>(_handleChooseCurrentEvent);
  }

  void _handleLoadCurrentLocationEvent(
      LoadCurrentLocationEvent event, Emitter<MapState> emit) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? address = prefs.getString(prefsCurrent);
      final double? longitude = prefs.getDouble(prefsCurrentLong);
      final double? latitude = prefs.getDouble(prefsCurrentLati);
      if (address != null && longitude != null && latitude != null) {
        currentLocation = LocationModel(
            address: address, latitude: latitude, longitude: longitude);
        debugPrint('Loaded currentLocation from prefs');
      } else {
        locationsForApp = await locationRepository.loadLocations();
        currentLocation = locationsForApp[0];
        debugPrint('Loaded currentLocation from repository');
      }
      emit(MapIdle(locationsForApp, currentLocation));
    } catch (e) {
      emit(MapError(locationsForApp, currentLocation));
    }
  }

  void _hanleLoadLocationsEvent(
      LoadLocationsEvent event, Emitter<MapState> emit) async {
    try {
      final SharedPreferences prefs = await _prefs;
      if (locationsForApp.isEmpty == true) {
        locationsForApp = await locationRepository.loadLocations();
        debugPrint('LoadingLocations');
      }
      final currentLocation = locationsForApp.firstWhere(
          (element) => element.address == prefs.getString(prefsCurrent),
          orElse: () => locationsForApp[0]);
      emit(MapSuccessLoad(locationsForApp, currentLocation));
      debugPrint(prefs.getString(prefsCurrent));
      emit(MapIdle(locationsForApp, currentLocation));
    } catch (e) {
      emit(MapError(locationsForApp, currentLocation));
    }
  }

  Future<void> _handleChooseCurrentEvent(
      ChooseCurrentLocationEvent event, Emitter<MapState> emit) async {
    final SharedPreferences prefs = await _prefs;
    currentLocation = event.current;
    prefs.setString(prefsCurrent, event.current.address);
    prefs.setDouble(prefsCurrentLong, event.current.longitude);
    prefs.setDouble(prefsCurrentLati, event.current.latitude);
    emit(MapChangedCurrentLocation(state.locations, currentLocation));
  }
}
