import 'package:flutter/cupertino.dart';
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

  loadingPage(ChapterModel chapterDownload, bool isDownloaded)async {
    this.isDownloaded(isDownloaded);
    pages.clear();
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
