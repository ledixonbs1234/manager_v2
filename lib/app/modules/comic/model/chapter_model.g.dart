// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) {
  return ChapterModel(
    name: json['name'] as String,
    url: json['url'] as String,
    date: json['date'] as String,
    nameComic: json['nameComic'] as String,
  )..pages = (json['pages'] as List)
      ?.map((e) =>
          e == null ? null : PageModel.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'date': instance.date,
      'nameComic': instance.nameComic,
      'pages': instance.pages,
    };
