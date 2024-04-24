part of 'permission_bloc.dart';

sealed class PermissionEvent {
  const PermissionEvent();
}

class IsLocationPermissionGrantedEvent implements PermissionEvent{
}