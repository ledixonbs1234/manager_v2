import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/modules/comic/model/comic_search_model.dart';
import 'package:manager_v2/app/modules/comic/model/comics_model.dart';
import 'package:manager_v2/app/modules/info/model/comic_info_model.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

import '../../tool.dart';

class InfoController extends GetxController {
  final AllRespository respository;

  InfoController({@required this.respository});

  var comic = ComicInfoModel().obs;
  ComicsModel comicsFi;

  infoLoading(String urlComic) async {
    var network = await respository.isNetwork();
    comicsFi = Glob().getComicsFile();
    if (network) {
      //Co mang
      //Thuc hien lay thong tin comic
      comic(await respository.getInfoComic(urlComic));
      printInfo(info: 'Da update xong comic');
    } else {
      //Rot mang
      //thuc hien kiem tra thu co file json khong
      // comicsFi = respository.getComi('dd');
      // comicsFi.toJson()
      //neu co thi dua vao comic
      Get.dialog(Text('Khong co mang roi'));
    }
  }

  goChapterPage() {
    Get.toNamed(Routes.CHAPTER);
    var chapterController = Get.find<ChapterController>();
    chapterController.loadingChapter(
        comic.value);
  }

  deleteFile() {
    comicsFi = null;
    respository.deleteFileJson();
  }
}
