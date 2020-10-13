// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicsModel _$ComicsModelFromJson(Map<String, dynamic> json) {
  return ComicsModel(
    comics: (json['comics'] as List)
        ?.map((e) => e == null
            ? null
            : ComicInfoModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ComicsModelToJson(ComicsModel instance) =>
    <String, dynamic>{
      'comics': instance.comics,
    };
