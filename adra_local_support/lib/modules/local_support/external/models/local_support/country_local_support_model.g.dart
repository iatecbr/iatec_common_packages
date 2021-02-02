// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_local_support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryLocalSupportModel _$CountryLocalSupportModelFromJson(
    Map<String, dynamic> json) {
  return CountryLocalSupportModel(
    json['id'] as int,
    json['description'] as String,
    json['shortName'] as String,
  );
}

Map<String, dynamic> _$CountryLocalSupportModelToJson(
        CountryLocalSupportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'shortName': instance.shortName,
    };
