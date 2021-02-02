// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalCategoryModel _$LocalCategoryModelFromJson(Map<String, dynamic> json) {
  return LocalCategoryModel(
    json['id'] as int,
    json['description'] as String,
    json['isActive'] as bool,
  );
}

Map<String, dynamic> _$LocalCategoryModelToJson(LocalCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'isActive': instance.isActive,
    };
