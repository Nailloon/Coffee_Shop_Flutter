import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<IsPermissionGrantedEvent>(_handleLocationPermissionGrantedEvent);
    on<RequestPermissionEvent>(_handleRequestLocationPermissionEvent);
  }
  Future<void> _handleLocationPermissionGrantedEvent(
      IsPermissionGrantedEvent event, Emitter<PermissionState> emit) async {
    bool isGranted = await event.permission.isGranted;
    if (isGranted) {
      emit(PermissionGranted());
    } else {
      emit(PermissionDenied());
    }
  }

  Future<void> _handleRequestLocationPermissionEvent(
      RequestPermissionEvent event, Emitter<PermissionState> emit) async {
    var permission = await event.permission.request();
    bool isGranted = permission.isGranted;
    debugPrint(isGranted.toString());
    if (isGranted) {
      emit(PermissionGranted());
    } else {
      emit(PermissionNoChanges());
    }
  }
}
