import 'package:coffee_shop/src/features/map/model/location_model.dart';

abstract interface class ILocationRepository{
  Future<List<LocationModel>> loadLocations();
}