import 'package:coffee_shop/src/common/network/repositories/locations_repository/interface_location_repository.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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

  void _hanleLoadLocationsEvent(
      LoadLocationsEvent event, Emitter<MapState> emit) async {
    try {
      locationsForApp = await locationRepository.loadLocations();
      currentLocation = locationsForApp[0];
      debugPrint(currentLocation.toString());
      emit(MapInitial(locationsForApp, currentLocation));
    } catch (e) {
      rethrow;
    }
  }

  void _handleChooseCurrentEvent(
      ChooseCurrentLocationEvent event, Emitter<MapState> emit) {
    currentLocation = event.current;
    emit(MapInitial(state.locations, currentLocation));
  }
}
