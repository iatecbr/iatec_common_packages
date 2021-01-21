# iatec_authentication_firebase

IATec' Datasource Authentication using Firebase

## Install

Add in your pubspec.yaml
```yaml
dependencies:
  iatec_authentication_core:
    hosted:
      name: iatec_authentication_firebase
      url: http://pub.sdasystems.org
    version: 0.0.1
    
  iatec_authentication_firebase:
    hosted:
      name: iatec_authentication_firebase
      url: http://pub.sdasystems.org
    version: 0.0.3
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