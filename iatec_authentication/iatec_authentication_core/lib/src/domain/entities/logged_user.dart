class LoggedUser {
  final String name;
  final String email;
  final String urlPhoto;
  final String token;
  final List<ProviderLogin> providers;

  const LoggedUser({
    this.name,
    this.email,
    this.urlPhoto,
    this.token,
    this.providers,
  });

  LoggedUser copyWith({
    String name,
    String email,
    String urlPhoto,
    String token,
    List<ProviderLogin> providers,
  }) {
    return LoggedUser(
      name: name ?? this.name,
      email: email ?? this.email,
      urlPhoto: urlPhoto ?? this.urlPhoto,
      token: token ?? this.token,
      providers: providers ?? this.providers,
    );
  }
}

enum ProviderLogin { google, facebook, appleId }

Map<ProviderLogin, String> _nameProviderLogin = {};
Map<ProviderLogin, String> _emailProviderLogin = {};

extension ProviderLoginExtension on ProviderLogin {
  String get name => _nameProviderLogin[this];
  set name(String value) => _nameProviderLogin[this] = value;

  String get email => _emailProviderLogin[this];
  set email(String value) => _emailProviderLogin[this] = value;
}
