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
}
