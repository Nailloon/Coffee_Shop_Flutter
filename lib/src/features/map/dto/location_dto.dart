import 'package:coffee_shop/src/features/database/database/coffee_database.dart';

class LocationDTO {
  final String address;
  final double latitude;
  final double longitude;
  const LocationDTO(
      {required this.address, required this.latitude, required this.longitude});
  factory LocationDTO.fromJson(Map<String, dynamic> json) {
    return LocationDTO(
        address: json['address'],
        latitude: json['lat'],
        longitude: json['lng']);
  }
  factory LocationDTO.fromDB(Location location) {
    return LocationDTO(
        address: location.address,
        latitude: location.latitude,
        longitude: location.longitude);
  }
}
