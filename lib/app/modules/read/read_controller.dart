import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/model/chapter_model.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
import 'package:manager_v2/app/repository/all_respository.dart';

class ReadController extends GetxController {
  var pages = List<PageModel>().obs;

  loadingPage(ChapterModel chapterDownload) {
    pages.value = chapterDownload.pages;
  }
}
