import 'package:adra_design_system/adra_design_system.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:adra_local_support/modules/local_support/domain/use_cases/get_local_supports.dart';
import 'package:adra_local_support/modules/local_support/domain/use_cases/get_national_supports.dart';
import 'package:adra_local_support/modules/local_support/external/models/local_category_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'local_support_controller.g.dart';

class LocalSupportController = _LocalSupportControllerBase
    with _$LocalSupportController;

abstract class _LocalSupportControllerBase with Store {
  final IGetLocalSupports _getLocalSupports;
  final IGetNationalSupports _getNationalSupports;

  _LocalSupportControllerBase(
    this._getLocalSupports,
    this._getNationalSupports,
  ) {
    getAllSupports();
  }

  @observable
  GoogleMapController mapsController;

  @action
  void setGoogleController(_controller) => mapsController = _controller;

  @observable
  MapStates mapStates = MapStates.showLocalNationalSupport;

  @action
  void changeMapState(MapStates _mapStates) {
    mapStates = _mapStates;
  }

  @observable
  LocalCategoryModel selectedCategory;

  @action
  void setCategory(LocalCategory _category) {
    selectedCategory = _category;
    changeSelectedLocalSuport(null);
  }

  @observable
  List<LocalSupport> _localSupports;

  @computed
  List<LocalSupport> get localSupports {
    return selectedCategory == null
        ? _localSupports
        : _localSupports
            .where((element) => element.category.id == selectedCategory.id)
            .toList();
  }

  @observable
  List<NationalSupport> nationalSupport;

  @observable
  bool isLoading = true;

  @observable
  LocalSupport selectedLocalSupport;

  @action
  Future<void> getAllSupports() async {
    var resultLocalSupport = await _getLocalSupports.call(
      -22.8811403,
      -47.2322828,
    );

    resultLocalSupport.fold(
      (l) => AdraSnackbar.error(l.toString()),
      (r) => _localSupports = r,
    );

    var resultNationalSupport = await _getNationalSupports('1');

    resultNationalSupport.fold(
      (l) => AdraSnackbar.error(l.toString()),
      (r) => nationalSupport = r,
    );

    isLoading = false;
  }

  @action
  Future<void> changeSelectedLocalSuport(LocalSupport localSupport) async {
    changeMapState(localSupport == null
        ? MapStates.showLocalNationalSupport
        : MapStates.showSelectedLocal);
    selectedLocalSupport = localSupport;
  }
}

enum MapStates { fill, showLocalNationalSupport, showSelectedLocal }