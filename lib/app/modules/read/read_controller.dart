import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
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
  ChapterController chapterC = Get.find<ChapterController>();

  loadingPage(ChapterModel chapterDownload ) async {
    chapter(chapterDownload);
    this.isDownloaded(chapter.value.isDownloaded);
    pages.value.clear();
    if (isDownloaded.value) {
      pages.value = chapterDownload.pages;
      isShow(true);
      pages.refresh();
    } else {
      //thuc hien get page from resposity
      respository.getUrlImageFromUrlChapter(chapterDownload.url).then((value) {
        for (var page in value) {
          var pageM = PageModel(urlPath: page);
          pages.add(pageM);
        }
        isShow(true);
        pages.refresh();
      });
    }
  }

  toNextPage() {

    //get next page Chapter()
    var chapters = chapterC.chapters;
    var index =
        chapters.indexWhere((element) => element.name == chapter.value.name);
    if(index == 0)
      {
        Get.defaultDialog(content: Text('Da toi chapter cuoi'));
        return;
      }
    var nextCount = index - 1;
    loadingPage(chapters[nextCount]);
  }

  toPrevousPage() {
    var chapters = chapterC.chapters;
    var index =
        chapters.indexWhere((element) => element.name == chapter.value.name);
    if(index == chapters.length -1 )
    {
      Get.defaultDialog(content: Text('Da toi chap dau tien'));
      return;
    }
    var preCountCount = index + 1;
    loadingPage(chapters[preCountCount]);
  }
}
