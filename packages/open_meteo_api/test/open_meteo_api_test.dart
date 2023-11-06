import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:open_meteo_api/open_meteo_api.dart';
  class MockHttpClient extends Mock implements Dio {}
  class MockResponse extends Mock implements Response {}

class FakeUri extends Fake implements Uri {}
@GenerateMocks([Dio])
void main() {



group('Location', () { 
  group('fromJson', () { 
    test('return Coorect json response', () {
      expect(Location.fromJson({ 'id': 4887398,
              'name': 'Chicago',
              'latitude': 41.85003,
              'longitude': -87.65005,}),     isA<Location>()
              .having((w) => w.id, 'id', 4887398)
              .having((w) => w.name, 'name', 'Chicago')
              .having((w) => w.latitude, 'latitude', 41.85003)
              .having((w) => w.longitude, 'longitude', -87.65005),);
    });
  });
});
group('Weather', () { 
  group('fromJson', () { 
    test('return Correct weather response', () {
      expect( Weather.fromJson(
            <String, dynamic>{'temperature': 15.3, 'weathercode': 63},
          ),
          isA<Weather>()
              .having((w) => w.temperature, 'temperature', 15.3)
              .having((w) => w.weatherCode, 'weatherCode', 63),);
    });
  });
});







  group('OpenMeteoApiClient', () {
    late Dio dioClient;
    late OpenMeteoApiclient apiClient;

    // setUpAll(() {
    //   registerFallbackValue(FakeUri());
    // });

    setUp(() {
      dioClient = Dio();
      apiClient = OpenMeteoApiclient(dio: dioClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenMeteoApiclient(), isNotNull);
      });
    });

    group('locationSearch', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
         final response = MockResponse();
        when(() => response.statusCode).thenReturn(()=>200);
        when(() => response.data).thenReturn(()=>'{}');
      //  when(() => httpClient.get(any())).thenAnswer((_) async => response);
      //  final response = dioClient.get('https://geocoding-api.open-meteo.com/v1/search?name=Mumbai&count=1',);
        when(() => dioClient.get('geocoding-api.open-meteo.com/v1/search')).thenAnswer( response as Answering<Future<Response> Function()>);
      
   
        try {
          await apiClient.loactionSearch(city: 'Mumbai');
        } catch (_) {}
        verify(
          () => dioClient.get(
            
              'geocoding-api.open-meteo.com/v1/search',
           
            queryParameters:  {'name': query, 'count': '1'},
            
          ),
        ).called(1);
      });

      // test('throws LocationRequestFailure on non-200 response', () async {
      //   final response = MockResponse();
      //   when(() => response.statusCode).thenReturn(400);
      //   when(() => httpClient.get(any())).thenAnswer((_) async => response);
      //   expect(
      //     () async => apiClient.locationSearch(query),
      //     throwsA(isA<LocationRequestFailure>()),
      //   );
      // });

      // test('throws LocationNotFoundFailure on error response', () async {
      //   final response = MockResponse();
      //   when(() => response.statusCode).thenReturn(200);
      //   when(() => response.body).thenReturn('{}');
      //   when(() => httpClient.get(any())).thenAnswer((_) async => response);
      //   await expectLater(
      //     apiClient.locationSearch(query),
      //     throwsA(isA<LocationNotFoundFailure>()),
      //   );
      // });

      // test('throws LocationNotFoundFailure on empty response', () async {
      //   final response = MockResponse();
      //   when(() => response.statusCode).thenReturn(200);
      //   when(() => response.body).thenReturn('{"results": []}');
      //   when(() => dioClient.get(any())).thenAnswer((_) async => response);
      //   await expectLater(
      //     apiClient.loactionSearch(city: 'Mumbai'),
      //     throwsA(isA<LocationNotFoundFailure>()),
      //   );
      // });

//       test('returns Location on valid response', () async {
//         final response = MockResponse();
//         when(() => response.statusCode).thenReturn(200);
//         when(() => response.body).thenReturn(
//           '''
// {
//   "results": [
//     {
//       "id": 4887398,
//       "name": "Chicago",
//       "latitude": 41.85003,
//       "longitude": -87.65005
//     }
//   ]
// }''',
//         );
//         when(() => httpClient.get(any())).thenAnswer((_) async => response);
//         final actual = await apiClient.locationSearch(query);
//         expect(
//           actual,
//           isA<Location>()
//               .having((l) => l.name, 'name', 'Chicago')
//               .having((l) => l.id, 'id', 4887398)
//               .having((l) => l.latitude, 'latitude', 41.85003)
//               .having((l) => l.longitude, 'longitude', -87.65005),
//         );
//       });
    });

  });


}
