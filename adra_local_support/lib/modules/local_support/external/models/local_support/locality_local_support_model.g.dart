// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locality_local_support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalityLocalSupportModel _$LocalityLocalSupportModelFromJson(
    Map<String, dynamic> json) {
  return LocalityLocalSupportModel(
    json['id'] as int,
    json['country'] == null
        ? null
        : CountryLocalSupportModel.fromJson(
            json['country'] as Map<String, dynamic>),
    json['state'] as String,
    json['city'] as String,
    json['stateAcronym'] as String,
  );
}

Map<String, dynamic> _$LocalityLocalSupportModelToJson(
        LocalityLocalSupportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country':
          const CountryLocalSupportToModelConverter().toJson(instance.country),
      'state': instance.state,
      'city': instance.city,
      'stateAcronym': instance.stateAcronym,
    };
