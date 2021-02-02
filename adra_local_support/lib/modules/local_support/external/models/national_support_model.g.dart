// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'national_support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationalSupportModel _$NationalSupportModelFromJson(Map<String, dynamic> json) {
  return NationalSupportModel(
    json['id'] as int,
    json['countryId'] as int,
    json['description'] as String,
    json['phoneNumber'] as String,
    json['isActive'] as bool,
  );
}

Map<String, dynamic> _$NationalSupportModelToJson(
        NationalSupportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryId': instance.countryId,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'isActive': instance.isActive,
    };
