import 'package:dartz/dartz.dart';
import 'package:iatec_localization/src/domain/usecases/proccess_phrase.dart';
import 'localization.dart';
import 'localization_module.dart' as module;

extension LocalizationExtension on String {
  String i18n({String defaultValue, List<String> arguments}) {
    if (!Localization.isInitialized && defaultValue == null) {
      throw '''LOCALIZATION NOT INITIZALIZED:
    Add in your code
    await Localization.init('pt-BR');
    ''';
    }

    if (!Localization.isInitialized && defaultValue != null) {
      return defaultValue;
    }

    final usecase = module.resolve<ProccessValue>();
    final result = usecase.call(
      this,
      localizedPhrase: Localization.localizedPhrase,
      defaultValue: defaultValue,
      arguments: arguments,
    );
    return result.fold((l) {
      print('$l | $this');
      return this;
    }, id);
  }
}
