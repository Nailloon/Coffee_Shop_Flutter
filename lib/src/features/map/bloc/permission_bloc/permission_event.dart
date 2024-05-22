part of 'permission_bloc.dart';

sealed class PermissionEvent {}

class IsPermissionGrantedEvent implements PermissionEvent {
  final PermissionWithService permission;
  const IsPermissionGrantedEvent(this.permission);
}

class RequestPermissionEvent implements PermissionEvent {
  final PermissionWithService permission;
  const RequestPermissionEvent(this.permission);
}
