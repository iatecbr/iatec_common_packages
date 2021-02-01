import 'package:adra_local_support/modules/local_support/domain/entities/local_support/country_local_support.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_local_support_model.g.dart';

@JsonSerializable()
class CountryLocalSupportModel extends CountryLocalSupport {
  CountryLocalSupportModel(int id, String description, String shortName)
      : super(id, description, shortName);

  factory CountryLocalSupportModel.fromJson(Map<String, dynamic> json) =>
      _$CountryLocalSupportModelFromJson(json);

  static List<CountryLocalSupportModel> fromJsonList(List<dynamic> list) {
    if (list == null) return null;
    return list
        .map<CountryLocalSupportModel>(
            (item) => CountryLocalSupportModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() => _$CountryLocalSupportModelToJson(this);
}

class CountryLocalSupportToModelConverter
    implements JsonConverter<CountryLocalSupport, CountryLocalSupportModel> {
  const CountryLocalSupportToModelConverter();

  @override
  CountryLocalSupport fromJson(CountryLocalSupportModel model) =>
      CountryLocalSupport(model.id, model.description, model.shortName);

  @override
  CountryLocalSupportModel toJson(CountryLocalSupport object) =>
      CountryLocalSupportModel(object.id, object.description, object.shortName);
}
