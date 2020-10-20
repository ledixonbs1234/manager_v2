// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageModel _$PageModelFromJson(Map<String, dynamic> json) {
  return PageModel(
    index: json['index'] as int,
    name: json['name'] as String,
    urlPath: json['urlPath'] as String,
    urlRealpath: json['urlRealpath'] as String,
    progress: json['progress'] as String,
  )..isDownloaded = json['isDownloaded'] as bool;
}

Map<String, dynamic> _$PageModelToJson(PageModel instance) => <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'urlPath': instance.urlPath,
      'urlRealpath': instance.urlRealpath,
      'isDownloaded': instance.isDownloaded,
      'progress': instance.progress,
    };
