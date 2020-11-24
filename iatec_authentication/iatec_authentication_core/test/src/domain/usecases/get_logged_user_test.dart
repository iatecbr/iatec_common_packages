import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_authentication_core/iatec_authentication_core.dart';
import 'package:iatec_authentication_core/src/domain/services/get_logged_user_service.dart';
import 'package:iatec_authentication_core/src/domain/usecases/get_logged_user.dart';
import 'package:mockito/mockito.dart';

class GetLoggedUserServiceMock extends Mock implements GetLoggedUserService {}

void main() {
  GetLoggedUserService service;
  GetLoggedUser usecase;
  setUpAll(() {
    service = GetLoggedUserServiceMock();
    usecase = GetLoggedUserImpl(service: service);
  });

  test('should get LoggedUser object', () async {
    const user = LoggedUser();
    when(service.getUser()).thenAnswer((_) async => const Right(user));
    final result = await usecase();
    // ignore: inference_failure_on_instance_creation
    expect(result, const Right(user));
  });
  test('should throw exception and return a AuthFailure', () async {
    when(service.getUser())
        .thenAnswer((_) async => const Left(NotUserLogged()));
    final result = await usecase();
    // ignore: inference_failure_on_instance_creation
    expect(result, const Left(NotUserLogged()));
  });
}
