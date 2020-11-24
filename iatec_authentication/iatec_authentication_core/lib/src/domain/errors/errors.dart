abstract class AuthFailure implements Exception {
  final String message;

  const AuthFailure({this.message});
}

class LogoutFailure implements Exception {
  final String message;

  const LogoutFailure({this.message});
}

class CredentialsError extends AuthFailure {
  const CredentialsError({String message}) : super(message: message);
}

class DuplicatedAccountProviderError extends AuthFailure {
  const DuplicatedAccountProviderError({String message})
      : super(message: message);
}

class GoogleLoginError extends AuthFailure {
  const GoogleLoginError({String message}) : super(message: message);
}

class AppleIdLoginError extends AuthFailure {
  const AppleIdLoginError({String message}) : super(message: message);
}

class FacebookLoginError extends AuthFailure {
  const FacebookLoginError({String message}) : super(message: message);
}

class NotUserLogged extends AuthFailure {
  const NotUserLogged({String message}) : super(message: message);
}

class LinkAccountError extends AuthFailure {
  const LinkAccountError({String message}) : super(message: message);
}

class DeleteAccountError extends AuthFailure {
  const DeleteAccountError({String message}) : super(message: message);
}
