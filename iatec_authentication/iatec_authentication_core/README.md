# IATec Authentication Core

## Compatibility

- Dart: 2.13.1
- Flutter: 2.2.1 (stable)

## Installation

Add in your pubspec.yaml

```yaml
dependencies:
  iatec_authentication_core:
    hosted:
      name: iatec_authentication_core
      url: http://pub.sdasystems.org
    version: ^1.0.0
```

## Dependency

You need implement a ```AuthDatasource``` and register with method ```IAtecAuth.registerAuthDatasource```.

```dart
class MyDatasource implements AuthDatasource {
    ...
}

...

IAtecAuth.registerAuthDatasource(MyDatasource());

```

OR use *iatec_authentication_firebase* package;

## Usage

```dart
import 'package:iatec_authentication_core/iatec_authentication_core.dart'

...

final result = await IATecAuth.login(ProviderLogin.google);
result.fold((error){
    dispachError(error);
}, (user){
    print(user);
});


```


| Methods       | Return Success| Return Error   |   
|---------------|---------------|----------------|
| login         | LoggedUser    |  AuthFailure   |  
| logout        | Unit          |  LogoutFailure |  
| getLoggedUser | LoggedUser    |  AuthFailure   |  
| deleteAccount | Unit          |  AuthFailure   |  
| linkAccount   | LoggedUser    |  AuthFailure   |  
 