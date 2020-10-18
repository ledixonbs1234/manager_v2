import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/model/chapter_model.dart';
import 'package:manager_v2/app/modules/comic/model/comics_model.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
import 'package:manager_v2/app/modules/info/model/comic_info_model.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

class ChaptersViewModel {
  String name;
  double downloadCurrentValue;
  var isDownload = DownloadEnum.None.obs;

  ChaptersViewModel({this.name});
}

enum DownloadEnum { None, Downloading, Completed, Error }

class ChapterController extends GetxController {
  final AllRespository respository;

  ChapterController({@required this.respository});

  var chapters = List<ChapterModel>();
  RxList<ChaptersViewModel> chaptersView = List<ChaptersViewModel>().obs;
  var currentChapter;

  ComicsModel comicsFi;
  ComicInfoModel comicFinded;
  ComicInfoModel comicOnlyInfo;

  loadingChapter(ComicInfoModel comic, ComicsModel comicsFi) async {
    respository.count++;

    printInfo(info: '${respository.count++} in chapter');
    this.comicsFi = comicsFi;
    this.comicOnlyInfo = comic;

    chapters = await respository.getChapterFromUrl(comic.url);
    chaptersView.clear();
    for (var chapterv in chapters) {
      chaptersView.add(ChaptersViewModel(name: chapterv.name));
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
      int index =
          chaptersView.indexWhere((element) => element.name == chapter.name);
      if (index != -1) {
        chaptersView[index].isDownload(DownloadEnum.Completed);
      }
    }
  }

  downloadChapter(int index) async {
    chaptersView[index].isDownload(DownloadEnum.Downloading);
    chaptersView[index].downloadCurrentValue = 0;
    chaptersView.refresh();
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
    }

    chapters[index].pages = List<PageModel>();
    int countPage = 0;
    //thuc hien download chapter trong nay
    await respository.downloadChapter(chapters[index],
        (PageModel value, int maxPage) {
      if (value == null) {
        //xoa chapter download loi
        chaptersView[index].isDownload(DownloadEnum.Error);
        chapters[index].pages.clear();
        chaptersView[index].downloadCurrentValue = 0;
        chaptersView.refresh();
        printInfo(info: 'Download bi loi Khong download duoc');
        Get.defaultDialog(title: "${chaptersView[index].name} bi loi");
      } else {
        chapters[index].pages.add(value);

        chaptersView[index].downloadCurrentValue =
            num.parse((countPage / maxPage).toStringAsFixed(1));
        chaptersView.refresh();
        countPage++;
      }
    });
    if (chaptersView[index].isDownload.value == DownloadEnum.Error) {
      comicFinded.chapters
          .removeWhere((element) => element.name == chapters[index].name);
      return;
    }
    chapters[index].pages.sort((a, b) => a.index.compareTo(b.index));
    chaptersView[index].isDownload(DownloadEnum.Completed);
    chaptersView.refresh();
    Get.snackbar(
        'Download Info', 'Download thanh cong ${chaptersView[index].name}');
    printInfo(info: 'Download xong chapter ${chapters[index].name}');

    comicFinded.chapters
        .removeWhere((element) => element.name == chapters[index].name);
    comicFinded.chapters.add(chapters[index]);

    comicsFi.comics.removeWhere((element) => element.name == comicFinded.name);
    comicsFi.comics.add(comicFinded);
    //update respository
    respository.comicsModel = comicsFi;

    //save comic to file
    var jsonOject = comicsFi.toJson();
    respository.saveComicToFile(jsonOject);
    printInfo(info: 'So luong chapter ${comicFinded.chapters.length}');
  }

  toReadPage(int index) {
    var indexCurrent = comicFinded.chapters
        .indexWhere((element) => element.name == chaptersView[index].name);
    printInfo(info: '${chaptersView[index].name}');

    currentChapter = comicFinded.chapters[indexCurrent];
    Get.toNamed(Routes.READ);
  }
}
