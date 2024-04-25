part of 'map_bloc.dart';

sealed class MapState{
  final List<LocationModel> locations;
  final LocationModel? current;
  const MapState(this.locations, this.current);
}

final class MapInitial extends MapState{
  const MapInitial(super.locations, super.current);
}
final class MapChanged extends MapState{
  const MapChanged(super.locations, super.current);
}

final class MapError extends MapState{
  const MapError(super.locations, super.current);
}
