// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_support_filter_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocalSupportFilterController
    on _LocalSupportFilterControllerBase, Store {
  Computed<List<LocalCategory>> _$categoriesComputed;

  @override
  List<LocalCategory> get categories => (_$categoriesComputed ??=
          Computed<List<LocalCategory>>(() => super.categories,
              name: '_LocalSupportFilterControllerBase.categories'))
      .value;

  final _$filterAtom = Atom(name: '_LocalSupportFilterControllerBase.filter');

  @override
  String get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(String value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$hasErrorAtom =
      Atom(name: '_LocalSupportFilterControllerBase.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  final _$_categoriesAtom =
      Atom(name: '_LocalSupportFilterControllerBase._categories');

  @override
  List<LocalCategory> get _categories {
    _$_categoriesAtom.reportRead();
    return super._categories;
  }

  @override
  set _categories(List<LocalCategory> value) {
    _$_categoriesAtom.reportWrite(value, super._categories, () {
      super._categories = value;
    });
  }

  final _$refreshCategoriesAsyncAction =
      AsyncAction('_LocalSupportFilterControllerBase.refreshCategories');

  @override
  Future<dynamic> refreshCategories() {
    return _$refreshCategoriesAsyncAction.run(() => super.refreshCategories());
  }

  final _$_LocalSupportFilterControllerBaseActionController =
      ActionController(name: '_LocalSupportFilterControllerBase');

  @override
  void setFilter(String _filter) {
    final _$actionInfo = _$_LocalSupportFilterControllerBaseActionController
        .startAction(name: '_LocalSupportFilterControllerBase.setFilter');
    try {
      return super.setFilter(_filter);
    } finally {
      _$_LocalSupportFilterControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter: ${filter},
hasError: ${hasError},
categories: ${categories}
    ''';
  }
}
