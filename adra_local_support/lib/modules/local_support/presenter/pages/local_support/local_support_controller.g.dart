// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_support_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocalSupportController on _LocalSupportControllerBase, Store {
  Computed<List<LocalSupport>> _$localSupportsComputed;

  @override
  List<LocalSupport> get localSupports => (_$localSupportsComputed ??=
          Computed<List<LocalSupport>>(() => super.localSupports,
              name: '_LocalSupportControllerBase.localSupports'))
      .value;

  final _$mapsControllerAtom =
      Atom(name: '_LocalSupportControllerBase.mapsController');

  @override
  GoogleMapController get mapsController {
    _$mapsControllerAtom.reportRead();
    return super.mapsController;
  }

  @override
  set mapsController(GoogleMapController value) {
    _$mapsControllerAtom.reportWrite(value, super.mapsController, () {
      super.mapsController = value;
    });
  }

  final _$mapStatesAtom = Atom(name: '_LocalSupportControllerBase.mapStates');

  @override
  MapStates get mapStates {
    _$mapStatesAtom.reportRead();
    return super.mapStates;
  }

  @override
  set mapStates(MapStates value) {
    _$mapStatesAtom.reportWrite(value, super.mapStates, () {
      super.mapStates = value;
    });
  }

  final _$selectedCategoryAtom =
      Atom(name: '_LocalSupportControllerBase.selectedCategory');

  @override
  LocalCategoryModel get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(LocalCategoryModel value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  final _$_localSupportsAtom =
      Atom(name: '_LocalSupportControllerBase._localSupports');

  @override
  List<LocalSupport> get _localSupports {
    _$_localSupportsAtom.reportRead();
    return super._localSupports;
  }

  @override
  set _localSupports(List<LocalSupport> value) {
    _$_localSupportsAtom.reportWrite(value, super._localSupports, () {
      super._localSupports = value;
    });
  }

  final _$nationalSupportAtom =
      Atom(name: '_LocalSupportControllerBase.nationalSupport');

  @override
  List<NationalSupport> get nationalSupport {
    _$nationalSupportAtom.reportRead();
    return super.nationalSupport;
  }

  @override
  set nationalSupport(List<NationalSupport> value) {
    _$nationalSupportAtom.reportWrite(value, super.nationalSupport, () {
      super.nationalSupport = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_LocalSupportControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$selectedLocalSupportAtom =
      Atom(name: '_LocalSupportControllerBase.selectedLocalSupport');

  @override
  LocalSupport get selectedLocalSupport {
    _$selectedLocalSupportAtom.reportRead();
    return super.selectedLocalSupport;
  }

  @override
  set selectedLocalSupport(LocalSupport value) {
    _$selectedLocalSupportAtom.reportWrite(value, super.selectedLocalSupport,
        () {
      super.selectedLocalSupport = value;
    });
  }

  final _$getAllSupportsAsyncAction =
      AsyncAction('_LocalSupportControllerBase.getAllSupports');

  @override
  Future<void> getAllSupports() {
    return _$getAllSupportsAsyncAction.run(() => super.getAllSupports());
  }

  final _$changeSelectedLocalSuportAsyncAction =
      AsyncAction('_LocalSupportControllerBase.changeSelectedLocalSuport');

  @override
  Future<void> changeSelectedLocalSuport(LocalSupport localSupport) {
    return _$changeSelectedLocalSuportAsyncAction
        .run(() => super.changeSelectedLocalSuport(localSupport));
  }

  final _$_LocalSupportControllerBaseActionController =
      ActionController(name: '_LocalSupportControllerBase');

  @override
  void setGoogleController(dynamic _controller) {
    final _$actionInfo = _$_LocalSupportControllerBaseActionController
        .startAction(name: '_LocalSupportControllerBase.setGoogleController');
    try {
      return super.setGoogleController(_controller);
    } finally {
      _$_LocalSupportControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeMapState(MapStates _mapStates) {
    final _$actionInfo = _$_LocalSupportControllerBaseActionController
        .startAction(name: '_LocalSupportControllerBase.changeMapState');
    try {
      return super.changeMapState(_mapStates);
    } finally {
      _$_LocalSupportControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(LocalCategory _category) {
    final _$actionInfo = _$_LocalSupportControllerBaseActionController
        .startAction(name: '_LocalSupportControllerBase.setCategory');
    try {
      return super.setCategory(_category);
    } finally {
      _$_LocalSupportControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mapsController: ${mapsController},
mapStates: ${mapStates},
selectedCategory: ${selectedCategory},
nationalSupport: ${nationalSupport},
isLoading: ${isLoading},
selectedLocalSupport: ${selectedLocalSupport},
localSupports: ${localSupports}
    ''';
  }
}
