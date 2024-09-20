import 'package:coffee_shop/src/features/map/dto/location_dto.dart';

abstract interface class ILocationsDataSource{
  Future<List<LocationDTO>> fetchLocations();
}