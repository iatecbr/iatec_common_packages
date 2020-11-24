import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_localization/iatec_localization.dart';

void main() {
  const MethodChannel channel = MethodChannel('iatec_localization');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
