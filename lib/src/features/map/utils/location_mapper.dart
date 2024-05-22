import 'package:coffee_shop/src/features/map/dto/location_dto.dart';
import 'package:coffee_shop/src/features/map/model/location_model.dart';

extension LocationMapper on LocationDTO {
  LocationModel toModel() =>
      LocationModel(address: address, latitude: latitude, longitude: longitude);
}
