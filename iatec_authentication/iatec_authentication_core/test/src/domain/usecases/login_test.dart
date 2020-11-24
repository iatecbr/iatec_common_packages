import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_authentication_core/iatec_authentication_core.dart';
import 'package:iatec_authentication_core/src/domain/repositories/auth_repository.dart';
import 'package:iatec_authentication_core/src/domain/usecases/login.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements AuthRepository {}

void main() {
  AuthRepository repository;
  Login usecase;
  setUpAll(() {
    repository = LoginRepositoryMock();
    usecase = LoginImpl(repository: repository);
  });

  test('should do login with google provider', () async {
    const user = LoggedUser();
    when(repository.googleLogin()).thenAnswer((_) async => const Right(user));
    final result = await usecase(provider: ProviderLogin.google);
    verify(repository.googleLogin()).called(1);

    expect(result | null, user);
  });
  test('should do login with facebook provider', () async {
    const user = LoggedUser();
    when(repository.facebookLogin()).thenAnswer((_) async => const Right(user));
    final result = await usecase(provider: ProviderLogin.facebook);
    verify(repository.facebookLogin()).called(1);
    expect(result | null, user);
  });
  test('should do login with appleId provider', () async {
    const user = LoggedUser();
    when(repository.appleIdLogin()).thenAnswer((_) async => const Right(user));
    final result = await usecase(provider: ProviderLogin.appleId);
    verify(repository.appleIdLogin()).called(1);

    expect(result | null, user);
  });
}
