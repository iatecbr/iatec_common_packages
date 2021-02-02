import 'package:adra_local_support/modules/local_support/domain/entities/local_support/locality_local_support.dart';

import 'country_local_support_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locality_local_support_model.g.dart';

@CountryLocalSupportToModelConverter()
@JsonSerializable()
class LocalityLocalSupportModel extends LocalityLocalSupport {
  LocalityLocalSupportModel(
    int id,
    CountryLocalSupportModel country,
    String state,
    String city,
    String stateAcronym,
  ) : super(
          id,
          country,
          state,
          city,
          stateAcronym,
        );

  factory LocalityLocalSupportModel.fromJson(Map<String, dynamic> json) =>
      _$LocalityLocalSupportModelFromJson(json);

  static List<LocalityLocalSupportModel> fromJsonList(List<dynamic> list) {
    if (list == null) return null;
    return list
        .map<LocalityLocalSupportModel>(
            (item) => LocalityLocalSupportModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() => _$LocalityLocalSupportModelToJson(this);
}

class LocalityLocalSupportToModelConverter
    implements JsonConverter<LocalityLocalSupport, LocalityLocalSupportModel> {
  const LocalityLocalSupportToModelConverter();

  @override
  LocalityLocalSupport fromJson(LocalityLocalSupportModel model) =>
      LocalityLocalSupport(
        model.id,
        model.country,
        model.state,
        model.city,
        model.stateAcronym,
      );

  @override
  LocalityLocalSupportModel toJson(LocalityLocalSupport object) =>
      LocalityLocalSupportModel(
        object.id,
        object.country,
        object.state,
        object.city,
        object.stateAcronym,
      );
}
