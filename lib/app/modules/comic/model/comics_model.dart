
import 'package:json_annotation/json_annotation.dart';
import 'package:manager_v2/app/modules/info/model/comic_info_model.dart';

part 'comics_model.g.dart';
@JsonSerializable()
class ComicsModel{
  List<ComicInfoModel> comics;
  ComicsModel({this.comics});
  factory ComicsModel.fromJson(Map<String,dynamic> json) => _$ComicsModelFromJson(json);
  Map<String,dynamic> toJson() => _$ComicsModelToJson(this);
}