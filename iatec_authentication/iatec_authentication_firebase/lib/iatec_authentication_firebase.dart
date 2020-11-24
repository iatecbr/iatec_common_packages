library iatec_authentication_firebase;

export 'src/providers/provider_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iatec_authentication_core/iatec_authentication_core.dart';
import 'package:iatec_authentication_firebase/src/firebase_datasource.dart';
import 'package:iatec_authentication_firebase/src/providers/provider_options.dart';
import 'package:iatec_authentication_firebase/src/providers/provider_service.dart';

bool _isInitialized = false;

Future<void> startFirebaseDatasource(ProviderOptions options) async {
  if (!_isInitialized) {
    final provider = ProviderService(options);
    await Firebase.initializeApp();
    final datasource = FirebaseDatasource(
        provider: provider, firebaseAuth: FirebaseAuth.instance);
    IATecAuth.registerAuthDatasource(datasource);
    _isInitialized = true;
  }
}
