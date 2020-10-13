import 'package:json_annotation/json_annotation.dart';
import 'package:manager_v2/app/modules/comic/model/chapter_model.dart';
part 'comic_info_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ComicInfoModel {
  int id;
  String name;
  String url;
  String urlImage;
  String tacgia;
  String luotXem;
  String tinhTrang;
  String noidung;
  String urlDocTuDau;
  String urlDocChapterCuoi;
  List<ChapterModel> chapters;
  ComicInfoModel(
      {this.url,
      this.urlImage,
      this.name,
      this.tacgia,
      this.luotXem,
      this.tinhTrang,
      this.noidung,
      this.urlDocTuDau,
      this.urlDocChapterCuoi});

  factory ComicInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ComicInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$ComicInfoModelToJson(this);
}
