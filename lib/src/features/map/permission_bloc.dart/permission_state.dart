part of 'permission_bloc.dart';

sealed class PermissionState {
  const PermissionState();
}

class PermissionInitial implements PermissionState {}

class PermissionGranted implements PermissionState {
}

class PermissionDenied implements PermissionState{
}
