import 'dart:convert';

import 'package:dio/dio.dart';

import '../open_meteo_api.dart';

class LocationRequestFailure implements Exception {}

class LocationNotFoundFailure implements Exception {}
class WeatherRequestFailure implements Exception {}

class WeatherNotFoundFailure implements Exception {}


class OpenMeteoApiclient{
  final Dio? dioClient;

  OpenMeteoApiclient({Dio? dio}):dioClient=dio??Dio();

static String baseUrlGeocoding = 'https://geocoding-api.open-meteo.com';
static String baseUrlWeather = 'https://api.open-meteo.com';
  


  Future<Location> loactionSearch({required String city}) async {
  late Location locationJson;
  try {
    final locationResponse = await dioClient!.get(
      '$baseUrlGeocoding/v1/search',
      queryParameters: {'name': city, 'count': 1},
    );
    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }
    print(locationResponse.runtimeType);

    // final  jsonData = jsonDecode(locationResponse.data) ;
    // print(jsonData.runtimeType);

    if (locationResponse.data['results'] == []) {
      throw LocationNotFoundFailure();
    }
     locationJson = Location.fromJson(locationResponse.data['results'][0]);
    return locationJson;
  } on DioException catch (e) {
    print(e.toString());
  } catch (e) {
    print(e);
  }

  return locationJson;
}

  Future<Weather> weatherSearch({required double longitude,required double latitude}) async {
  late Weather weatherJson;
  try {
    final weatherResponse = await dioClient!.get(
      '$baseUrlWeather/v1/forecast',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
       'current_weather': true},
    );
    print(weatherResponse);
    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

   // final jsonData = jsonDecode(weatherResponse.data);

    if (weatherResponse.data['current_weather']==null) {
      throw WeatherNotFoundFailure();
    }
     weatherJson = Weather.fromJson(weatherResponse.data['current_weather']);
    return weatherJson;
  } on DioException catch (e) {
    print(e.toString());
  } catch (e) {
    print(e);
  }

  return weatherJson;
}
}



