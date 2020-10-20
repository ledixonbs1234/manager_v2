import 'package:json_annotation/json_annotation.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
part 'chapter_model.g.dart';
@JsonSerializable()
class ChapterModel {
  final String name;
  final String url;
  final String date;
  final String nameComic;
  final String luotXem;
  List<PageModel> pages;

  ChapterModel({this.name, this.url, this.date,this.nameComic,this.luotXem});
  factory ChapterModel.fromJson(Map<String,dynamic> json) => _$ChapterModelFromJson(json);
  Map<String,dynamic> toJson() => _$ChapterModelToJson(this);
}