import 'package:adra_local_support/modules/local_support/domain/entities/local_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_category_model.g.dart';

@JsonSerializable()
class LocalCategoryModel extends LocalCategory {
  LocalCategoryModel(int id, String description, bool isActive)
      : super(id, description, isActive);

  factory LocalCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$LocalCategoryModelFromJson(json);

  static List<LocalCategoryModel> fromJsonList(List<dynamic> list) {
    if (list == null) return null;
    return list
        .map<LocalCategoryModel>((item) => LocalCategoryModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() => _$LocalCategoryModelToJson(this);
}

class LocalCategoryToModelConverter
    implements JsonConverter<LocalCategory, LocalCategoryModel> {
  const LocalCategoryToModelConverter();

  @override
  LocalCategory fromJson(LocalCategoryModel model) => LocalCategory(
        model.id,
        model.description,
        model.isActive,
      );

  @override
  LocalCategoryModel toJson(LocalCategory object) => LocalCategoryModel(
        object.id,
        object.description,
        object.isActive,
      );
}
