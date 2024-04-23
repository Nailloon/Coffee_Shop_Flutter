part of 'map_bloc.dart';

sealed class MapEvent {
  const MapEvent();
}

final class LoadLocationsEvent extends MapEvent {}

final class ChooseCurrentLocationEvent extends MapEvent {
  final LocationModel current;
  const ChooseCurrentLocationEvent(this.current);
}
