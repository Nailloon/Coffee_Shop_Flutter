import 'package:coffee_shop/src/common/network/repositories/locations_repository/interface_location_repository.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'map_event.dart';
part 'map_state.dart';

final class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc(this.locationRepository, this.locationsForApp, this.currentLocation)
      : super(MapInitial(locationsForApp, currentLocation)) {
    on<LoadLocationsEvent>(_hanleLoadLocationsEvent);
    on<ChooseCurrentLocationEvent>(_handleChooseCurrentEvent);
  }
  List<LocationModel> locationsForApp;
  LocationModel? currentLocation;
  final ILocationRepository locationRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void _hanleLoadLocationsEvent(
      LoadLocationsEvent event, Emitter<MapState> emit) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final locationsForApp = await locationRepository.loadLocations();
      final currentLocation = prefs.getString('currentLocation') == null
          ? locationsForApp[0]
          : locationsForApp.firstWhere(
              (element) =>
                  element.address == prefs.getString('currentLocation'),
            );
      debugPrint(prefs.getString('currentLocation'));
      emit(MapInitial(locationsForApp, currentLocation));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _handleChooseCurrentEvent(
      ChooseCurrentLocationEvent event, Emitter<MapState> emit) async {
    final SharedPreferences prefs = await _prefs;
    currentLocation = event.current;
    prefs.setString('currentLocation', event.current.address);
    emit(MapChanged(state.locations, currentLocation));
  }
}
