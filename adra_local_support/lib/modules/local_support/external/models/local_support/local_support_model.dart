import 'package:adra_local_support/modules/local_support/domain/entities/local_support/local_support.dart';

import '../local_category_model.dart';
import 'locality_local_support_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'local_support_model.g.dart';

@LocalCategoryToModelConverter()
@LocalityLocalSupportToModelConverter()
@JsonSerializable()
class LocalSupportModel extends LocalSupport {
  LocalSupportModel(
      int id,
      String name,
      LocalityLocalSupportModel locality,
      LocalCategoryModel category,
      String address,
      String complement,
      String neighborhood,
      String zipCode,
      double latitude,
      double longitude,
      double distance,
      bool isActive)
      : super(
          id,
          name,
          locality,
          category,
          address,
          complement,
          neighborhood,
          zipCode,
          latitude,
          longitude,
          distance,
          isActive,
        );

  factory LocalSupportModel.fromJson(Map<String, dynamic> json) =>
      _$LocalSupportModelFromJson(json);

  static List<LocalSupportModel> fromJsonList(List<dynamic> list) {
    if (list == null) return null;
    return list
        .map<LocalSupportModel>((item) => LocalSupportModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() => _$LocalSupportModelToJson(this);
}
