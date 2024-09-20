import 'dart:convert';

import 'package:coffee_shop/src/common/functions/convert_functions.dart';
import 'package:coffee_shop/src/common/functions/exception_functions.dart';
import 'package:coffee_shop/src/common/network/data_sources/locations_data_source/interface_locations_data_source.dart';
import 'package:coffee_shop/src/features/map/dto/location_dto.dart';
import 'package:http/http.dart' as http;

class LocationsDataSource implements ILocationsDataSource{
  final String baseUrl = 'coffeeshop.academy.effective.band';
  final String apiVersion = '/api/v1/locations';
  final http.Client client;
  const LocationsDataSource({required this.client});
  @override
  Future<List<LocationDTO>> fetchLocations() async{
    try {
      var url = Uri.https(baseUrl, '$apiVersion/');
      final response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        final List<LocationDTO> locations = [];
        List<dynamic> jsonList = returnJsonDataAsList(jsonData);
        for (var json in jsonList) {
          locations.add(LocationDTO.fromJson(json));
        }
        return locations;
      } else {
        throw Exception('Failed to fetch data');
      }
    } on Exception catch (e) {
      noInternet(e);
      rethrow;
    }
  }
}