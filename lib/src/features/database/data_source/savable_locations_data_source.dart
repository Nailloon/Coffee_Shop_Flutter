import 'package:coffee_shop/src/common/network/data_sources/locations_data_source/interface_locations_data_source.dart';
import 'package:coffee_shop/src/features/database/database/coffee_database.dart';
import 'package:coffee_shop/src/features/map/dto/location_dto.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

abstract interface class ISavableLocationsDataSource
    implements ILocationsDataSource {
  void saveLocation(LocationDTO location);
}

class SavableLocationsDataSource implements ISavableLocationsDataSource {
  final AppDatabase database;
  const SavableLocationsDataSource(this.database);

  @override
  Future<List<LocationDTO>> fetchLocations() async {
    final List<LocationDTO> locationsDto = [];
    final List<Location> locations =
        await database.select(database.locations).get();
    for (var location in locations) {
      locationsDto.add(LocationDTO.fromDB(location));
    }
    return locationsDto;
  }

  @override
  void saveLocation(LocationDTO location) {
    debugPrint(location.toString());
    database.into(database.locations).insertOnConflictUpdate(LocationsCompanion(
        address: Value(location.address),
        latitude: Value(location.latitude),
        longitude: Value(location.longitude)));
  }
}
