// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_support_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalSupportModel _$LocalSupportModelFromJson(Map<String, dynamic> json) {
  return LocalSupportModel(
    json['id'] as int,
    json['name'] as String,
    json['locality'] == null
        ? null
        : LocalityLocalSupportModel.fromJson(
            json['locality'] as Map<String, dynamic>),
    json['category'] == null
        ? null
        : LocalCategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    json['address'] as String,
    json['complement'] as String,
    json['neighborhood'] as String,
    json['zipCode'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    (json['distance'] as num)?.toDouble(),
    json['isActive'] as bool,
  );
}

Map<String, dynamic> _$LocalSupportModelToJson(LocalSupportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'locality': const LocalityLocalSupportToModelConverter()
          .toJson(instance.locality),
      'category':
          const LocalCategoryToModelConverter().toJson(instance.category),
      'address': instance.address,
      'complement': instance.complement,
      'neighborhood': instance.neighborhood,
      'zipCode': instance.zipCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distance': instance.distance,
      'isActive': instance.isActive,
    };
