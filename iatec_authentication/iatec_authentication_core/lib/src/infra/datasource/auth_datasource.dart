import 'package:iatec_authentication_core/src/domain/entities/logged_user.dart';

abstract class AuthDatasource {
  Future<LoggedUser> loginWithGoogle();
  Future<LoggedUser> loginWithFacebook();
  Future<LoggedUser> loginWithAppleId();
  Future<int> logout();
  Future<void> deleteAccount();
  Future<LoggedUser> getLoggedUser();
  Future<LoggedUser> linkAccount(ProviderLogin provider);
  Future<LoggedUser> unlinkAccount(ProviderLogin provider);
}
