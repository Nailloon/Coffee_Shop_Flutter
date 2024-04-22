import 'dart:io';

import 'package:coffee_shop/src/common/network/data_sources/locations_data_source/interface_locations_data_source.dart';
import 'package:coffee_shop/src/common/network/repositories/locations_repository/interface_location_repository.dart';
import 'package:coffee_shop/src/features/database/data_source/savable_locations_data_source.dart';
import 'package:coffee_shop/src/features/map/dto/location_dto.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';
import 'package:coffee_shop/src/features/map/utils/location_mapper.dart';
import 'package:flutter/material.dart';

class LocationRepository implements ILocationRepository {
  final ILocationsDataSource networkLocationDataSource;
  final ISavableLocationsDataSource savableLocationsDataSource;
  const LocationRepository(
      this.networkLocationDataSource, this.savableLocationsDataSource);

  @override
  Future<List<LocationModel>> loadLocations() async {
    List<LocationModel> locations = [];
    try {
      final List<LocationDTO> locationsDTO =
          await networkLocationDataSource.fetchLocations();
      for (var location in locationsDTO) {
        locations.add(location.toModel());
        debugPrint(location.address);
      }
      savableLocationsDataSource.saveLocations(locationsDTO);
      return locations;
    } on Exception catch (e) {
      if (e is SocketException) {
        final List<LocationDTO> locationsDTO =
            await savableLocationsDataSource.fetchLocations();
        for (var location in locationsDTO) {
          locations.add(location.toModel());
        }
        return locations;
      }
      rethrow;
    }
  }
}
