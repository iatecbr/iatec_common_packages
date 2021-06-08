import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:adra_local_support/modules/local_support/external/data_sources/local_support_data_source_impl.dart';
import 'package:adra_local_support/modules/local_support/external/models/local_support/local_support_model.dart';
import 'package:adra_local_support/modules/local_support/infra/data_sources/local_support_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

void main() {
  LocalSupportDataSource dataSource;
  Dio dioMock;
  setUp(() {
    dioMock = DioMock();
  });

  group('UseCase LocalSupportDataSource getLocalSupports Test', () {
    test('Test parse Model', () async {
      final httpResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: [
          {
            'id': 1,
            'name': 'name',
            'locality': {
              'id': 1,
              'country': {
                'id': 1,
                'description': 'Description',
                'shortName': 'short name'
              },
              'state': 'state',
              'city': 'city',
              'stateAcronym': 'stateAcronym',
            },
            'category': {
              'id': 1,
              'description': 'desc',
              'isActive': false,
            },
            'address': 'address',
            'complement': 'complement',
            'neighborhood': 'neighborhood',
            'zipCode': 'zipCode',
            'latitude': 2,
            'longitude': 4,
            'distance': 3,
            'isActive': true
          },
        ],
      );

      when(dioMock.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => httpResponse);

      dataSource = LocalSupportDataSourceImpl(dioMock);

      var featureMessage = await dataSource.getLocalSupports(1, 2);

      expect(featureMessage, isInstanceOf<List<LocalSupportModel>>());
    });
  });

  group('UseCase LocalSupportDataSource getLocalCategories Test', () {
    test('Test parse Model', () async {
      final httpResponse = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: [
          {"id": 0, "description": "string", "isActive": true}
        ],
      );

      when(dioMock.get(any)).thenAnswer((_) async => httpResponse);

      dataSource = LocalSupportDataSourceImpl(dioMock);
      var featureMessage = await dataSource.getLocalCategories();

      expect(featureMessage, isInstanceOf<List<LocalCategory>>());
    });
  });

  group('UseCase LocalSupportDataSource getNationalSupports Test', () {
    test('Test parse Model', () async {
      final httpResponse = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: [
            {
              "id": 0,
              "countryId": 0,
              "description": "string",
              "phoneNumber": "string",
              "isActive": true
            }
          ]);

      when(dioMock.get(any)).thenAnswer((_) async => httpResponse);

      dataSource = LocalSupportDataSourceImpl(dioMock);
      var featureMessage = await dataSource.getNationalSupports('1');

      expect(featureMessage, isInstanceOf<List<NationalSupport>>());
    });
  });
}
