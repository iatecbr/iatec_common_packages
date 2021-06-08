# IATec Authentication Firebase

## Compatibility

- Dart: 2.13.1
- Flutter: 2.2.1 (stable)

## Installation

Add in your pubspec.yaml
```yaml
dependencies:
  iatec_authentication_core:
    hosted:
      name: iatec_authentication_firebase
      url: http://pub.sdasystems.org
    version: 1.0.0
    
  iatec_authentication_firebase:
    hosted:
      name: iatec_authentication_firebase
      url: http://pub.sdasystems.org
    version: 1.0.0
```



## Usage

```dart

main(){

  startFirebaseDatasource(ProviderOptions(
      appleClientId: 'br.com.example', 
      appleRedirectUri: 'https://...',
    ),
  );
  ...
}

```