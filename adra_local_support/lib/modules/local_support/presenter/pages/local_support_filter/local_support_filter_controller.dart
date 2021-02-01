import 'package:adra_design_system/adra_design_system.dart';
import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:adra_local_support/modules/local_support/domain/use_cases/get_local_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'local_support_filter_controller.g.dart';

class LocalSupportFilterController = _LocalSupportFilterControllerBase
    with _$LocalSupportFilterController;

abstract class _LocalSupportFilterControllerBase with Store {
  final IGetLocalCategories _getLocalCategories;

  _LocalSupportFilterControllerBase(this._getLocalCategories) {
    refreshCategories();
  }

  final filterController = TextEditingController();

  @observable
  String filter = '';

  @action
  void setFilter(String _filter) => filter = _filter.toUpperCase();

  @observable
  bool hasError = false;

  @observable
  List<LocalCategory> _categories;

  @computed
  List<LocalCategory> get categories => filter.isEmpty
      ? _categories
      : _categories
          ?.where(
              (element) => element.description.toUpperCase().contains(filter))
          ?.toList();
  @action
  Future refreshCategories() async {
    var result = await _getLocalCategories();
    result.fold((l) {
      hasError = true;
      AdraSnackbar.error(l.message).show();
    }, (r) {
      return _categories = r;
    });
  }
}
