import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/model/chapter_model.dart';
import 'package:manager_v2/app/modules/comic/model/comic_search_model.dart';
import 'package:manager_v2/app/modules/comic/model/comics_model.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
import 'package:manager_v2/app/modules/info/model/comic_info_model.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

class ChaptersViewModel {
  String name;
  bool isDownloaded = false;

  ChaptersViewModel({this.name});
}

class ChapterController extends GetxController {
  final AllRespository respository;

  ChapterController({@required this.respository});

  var chapters = List<ChapterModel>();
  var chaptersView = List<ChaptersViewModel>().obs;
  var currentChapter;

  ComicsModel comicsFi;
  ComicInfoModel comicFinded;
  ComicInfoModel comicOnlyInfo;

  loadingChapter(ComicInfoModel comic, ComicsModel comicsFi) async {
    this.comicsFi = comicsFi;
    this.comicOnlyInfo = comic;

    chapters = await respository.getChapterFromUrl(comic.url);
    chaptersView.clear();
    for (var chapterv in chapters) {
      chaptersView.value.add(ChaptersViewModel(name: chapterv.name));
    }

    if (comicsFi == null) return;
    //thuc hien kiem tra co comic trong nay khong
    printInfo(info: '${comic.name.hashCode} vs ${comicsFi.comics[0].id}');
    var indexComicFinded =
        comicsFi.comics.indexWhere((element) => element.name == comic.name);
    if (indexComicFinded == -1) return;
    comicFinded = comicsFi.comics[indexComicFinded];
    //Liet ke cac chapter hien ra
    for (var chapter in comicFinded.chapters) {
      int index = chaptersView.value
          .indexWhere((element) => element.name == chapter.name);
      if (index != -1) {
        chaptersView[index].isDownloaded = true;
      }
    }
  }

  downloadChapter(int index) async {
    if (comicsFi == null) {
      //add Comic to comicsFi
      comicsFi = ComicsModel();
      comicsFi.comics = List<ComicInfoModel>();
      comicFinded = comicOnlyInfo;
      comicFinded.id = comicFinded.hashCode;
      comicFinded.chapters = List<ChapterModel>();
      // comicsFi.comics.add(comicOnlyInfo);
    } else if (comicFinded == null) {
      //thuc hien add comic to listcomic
      // comicOnlyInfo.chapters.add(chapters[index]);
      // comicsFi.comics.add(comicOnlyInfo);
      comicFinded = comicOnlyInfo;
      comicFinded.id = comicFinded.hashCode;
      comicFinded.chapters = List<ChapterModel>();
    } else {
      int indexChapterHas = comicFinded.chapters
          .indexWhere((element) => element.name == chapters[index].name);
    }

    chapters[index].pages = List<PageModel>();
    //thuc hien download chapter trong nay
    await respository.downloadChapter(chapters[index], (PageModel value) {
      chapters[index].pages.add(value);
      chaptersView[index].isDownloaded = true;
    });
    chapters[index].pages.sort((a,b)=>a.index.compareTo(b.index));
    printInfo(info: 'Download xong chapter ${chapters[index].name}');
    // int indexChapterHas = comicFinded.chapters.indexWhere((element) => element.name == chapters[index].name);
    // if(indexChapterHas == -1)
    //   comicFinded.chapters.add(chapters[index]);
    // else
    //   {
    //     //xoa file
    //     comicFinded.chapters.removeAt(indexChapterHas);
    //     comicFinded.chapters.add(chapters[index]);
    //   }
    comicFinded.chapters
        .removeWhere((element) => element.name == chapters[index].name);
    comicFinded.chapters.add(chapters[index]);

    comicsFi.comics.removeWhere((element) => element.name == comicFinded.name);
    comicsFi.comics.add(comicFinded);

    //save comic to file
    var jsonOject = comicsFi.toJson();
    respository.saveComicToFile(jsonOject);
    printInfo(info: 'So luong chapter ${comicFinded.chapters.length}');
  }

  toReadPage(int index) {
    var indexCurrent = comicFinded.chapters.indexWhere((element) => element.name == chaptersView[index].name);

    currentChapter = comicFinded.chapters[indexCurrent];
    Get.toNamed(Routes.READ);
  }
}
