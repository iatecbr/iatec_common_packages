import 'package:connectivity/connectivity.dart';
import 'package:iatec_localization/src/infra/services/connection_check.dart';

class ConnectionCheckImpl implements ConnectionCheck {
  @override
  Future<bool> get isConnected async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}
