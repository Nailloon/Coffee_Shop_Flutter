import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<IsLocationPermissionGrantedEvent>(_handleLocationPermissionGrantedEvent);
    on<RequestLocationPermissionEvent>(_handleRequestLocationPermissionEvent);
  }
  Future<void> _handleLocationPermissionGrantedEvent(
      IsLocationPermissionGrantedEvent event,
      Emitter<PermissionState> emit) async {
    bool isGranted = await Permission.locationWhenInUse.isGranted;
    if (isGranted) {
      emit(PermissionGranted());
    } else {
      emit(PermissionDenied());
    }
  }

  Future<void> _handleRequestLocationPermissionEvent(
      RequestLocationPermissionEvent event,
      Emitter<PermissionState> emit) async {
    var permission = await Permission.locationWhenInUse.request();
    bool isGranted = permission.isGranted;
    debugPrint(isGranted.toString());
    if (isGranted) {
      emit(PermissionChanged());
    } else {
      emit(PermissionNoChanges());
    }
  }
}
