// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComicInfoModel _$ComicInfoModelFromJson(Map<String, dynamic> json) {
  return ComicInfoModel(
    url: json['url'] as String,
    urlImage: json['urlImage'] as String,
    name: json['name'] as String,
    tacgia: json['tacgia'] as String,
    luotXem: json['luotXem'] as String,
    tinhTrang: json['tinhTrang'] as String,
    noidung: json['noidung'] as String,
    urlDocTuDau: json['urlDocTuDau'] as String,
    urlDocChapterCuoi: json['urlDocChapterCuoi'] as String,
  )
    ..id = json['id'] as int
    ..chapters = (json['chapters'] as List)
        ?.map((e) =>
            e == null ? null : ChapterModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ComicInfoModelToJson(ComicInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'urlImage': instance.urlImage,
      'tacgia': instance.tacgia,
      'luotXem': instance.luotXem,
      'tinhTrang': instance.tinhTrang,
      'noidung': instance.noidung,
      'urlDocTuDau': instance.urlDocTuDau,
      'urlDocChapterCuoi': instance.urlDocChapterCuoi,
      'chapters': instance.chapters?.map((e) => e?.toJson())?.toList(),
    };
