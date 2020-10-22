import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/model/chapter_model.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
import 'package:manager_v2/app/repository/all_respository.dart';

class ReadController extends GetxController {
  ReadController({this.respository});

  final AllRespository respository;
  var pages = List<PageModel>().obs;
  var isDownloaded = false.obs;
  var isShow = false.obs;
  var chapter = ChapterModel().obs;
  var isShowFLoat = false.obs;
  final GlobalKey<FabCircularMenuState> fabkey = GlobalKey();

  loadingPage(ChapterModel chapterDownload, bool isDownloaded)async {
    chapter(chapterDownload);
    this.isDownloaded(isDownloaded);
    pages =List<PageModel>().obs;
    if (isDownloaded) {
      pages.value = chapterDownload.pages;
      isShow(true);
    } else {
      //thuc hien get page from resposity
      respository.getUrlImageFromUrlChapter(chapterDownload.url).then((value) {
        for (var page in value) {
          var pageM = PageModel(urlPath: page);
          pages.add(pageM);
        }
        isShow(true);
      });
    }
  }
}
