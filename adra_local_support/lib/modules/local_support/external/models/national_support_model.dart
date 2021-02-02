import 'package:adra_local_support/modules/local_support/domain/entities/national_support.dart';
import 'package:json_annotation/json_annotation.dart';

part 'national_support_model.g.dart';

@JsonSerializable()
class NationalSupportModel extends NationalSupport {
  NationalSupportModel(int id, int countryId, String description,
      String phoneNumber, bool isActive)
      : super(id, countryId, description, phoneNumber, isActive);

  factory NationalSupportModel.fromJson(Map<String, dynamic> json) =>
      _$NationalSupportModelFromJson(json);

  static List<NationalSupportModel> fromJsonList(List<dynamic> list) {
    if (list == null) return null;
    return list
        .map<NationalSupportModel>(
            (item) => NationalSupportModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() => _$NationalSupportModelToJson(this);
}
