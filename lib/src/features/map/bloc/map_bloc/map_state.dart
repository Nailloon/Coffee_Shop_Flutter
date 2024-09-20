part of 'map_bloc.dart';

sealed class MapState{
  final List<LocationModel> locations;
  final LocationModel? current;
  const MapState(this.locations, this.current);
}

final class MapIdle extends MapState{
  const MapIdle(super.locations, super.current);
}

final class MapSuccessLoad extends MapState{
  const MapSuccessLoad(super.locations, super.current);
}

final class MapChangedCurrentLocation extends MapState{
  const MapChangedCurrentLocation(super.locations, super.current);
}

final class MapError extends MapState{
  const MapError(super.locations, super.current);
}
