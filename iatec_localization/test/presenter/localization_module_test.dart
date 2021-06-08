import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_localization/iatec_localization.dart';
import 'package:iatec_localization/src/infra/services/connection_check.dart';
import 'package:iatec_localization/src/presenter/localization_module.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements DioForNative {}

class ConnectionCheckMock extends Mock implements ConnectionCheck {}

void main() {
  final dio = DioMock();
  final connectionCheckMock = ConnectionCheckMock();

  test('deve inicializar o Localziation', () async {
    when(dio.get<Map<String, String>>(any, options: anyNamed('options')))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: {'test': 'teste'},
      ),
    );
    when(connectionCheckMock.isConnected).thenAnswer((_) async => true);

    changeBind<Dio>(dio);
    changeBind<ConnectionCheck>(connectionCheckMock);
    changeBind<bool>(true);
    await Localization.init(locate: 'null', url: 'null');
    expect(Localization.isInitialized, true);
    expect('test'.i18n(), 'teste');
  });
}
