import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<IsLocationPermissionGrantedEvent>(_handleLocationPermissionGrantedEvent);
  }
  Future<void> _handleLocationPermissionGrantedEvent(
      IsLocationPermissionGrantedEvent event, Emitter<PermissionState> emit) async{
        bool isGranted = await Permission.locationWhenInUse.isGranted;
        if (isGranted){emit(PermissionGranted());}
        else{emit(PermissionDenied());}
  }
}