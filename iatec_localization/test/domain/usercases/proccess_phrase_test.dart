import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iatec_localization/src/domain/entities/localized_phrase.dart';
import 'package:iatec_localization/src/domain/errors/errors.dart';
import 'package:iatec_localization/src/domain/usecases/proccess_phrase.dart';

void main() {
  final usecase = ProccessValueImpl();
  final localizedPhrase = LocalizedPhrase(
    locale: 'pt-BR',
    phrases: {
      'test-key-phrase': 'Test Key Value',
      'test-key-phrase-interpolate': 'Test interpolate %s',
    },
  );

  test('should proccess phrases ', () async {
    final result = usecase.call(
      'test-key-phrase',
      localizedPhrase: localizedPhrase,
    );
    expect(result | null, 'Test Key Value');
  });

  test('should return default if phrase not found', () async {
    final result = usecase.call('test-key-phrase-not-exist',
        localizedPhrase: null, defaultValue: 'Default phrase');
    expect(result | null, 'Default phrase');
  });

  test(
      'should throw  ProccessPhraseError when phrase and default value be null',
      () async {
    final result = usecase.call('test-key-phrase-not-exist',
        localizedPhrase: null, defaultValue: null);
    expect(result.fold(id, id), isA<ProccessPhraseError>());
  });
  test('should not exist phrases return default ', () async {
    final result = usecase.call('test-key-phrase-not-exist',
        localizedPhrase: null, defaultValue: 'Default phrase');
    expect(result | null, 'Default phrase');
  });

  test('should throw error not exist phrases and default value is empty',
      () async {
    final result = usecase.call('test-key-phrase-not-exist',
        localizedPhrase: localizedPhrase);
    expect(result.fold(id, id), isA<ProccessPhraseError>());
  });

  test('should interpolate arguments', () async {
    final result = usecase.call(
      'test-key-phrase-interpolate',
      localizedPhrase: localizedPhrase,
      arguments: ['Bob'],
    );
    expect(result.fold(id, id), 'Test interpolate Bob');
  });

  test('should interpolate arguments with default value', () async {
    final result = usecase.call(
      'test-key-phrase-interpolate-default',
      localizedPhrase: localizedPhrase,
      defaultValue: 'Test interpolate %s, %s and %s',
      arguments: ['Bob', 'Charlie', 'George'],
    );
    expect(result.fold(id, id), 'Test interpolate Bob, Charlie and George');
  });
}
