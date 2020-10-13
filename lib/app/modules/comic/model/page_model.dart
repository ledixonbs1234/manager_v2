import 'package:json_annotation/json_annotation.dart';
part 'page_model.g.dart';
@JsonSerializable()
class PageModel {
  int index;
  final String name;
  final String urlPath;
  final String urlRealpath;
  bool isDownloaded = false;
   String progress;

  PageModel({this.index,this.name, this.urlPath, this.urlRealpath,this.progress});
  factory PageModel.fromJson(Map<String,dynamic> json) => _$PageModelFromJson(json);
  Map<String,dynamic> toJson() => _$PageModelToJson(this);
}