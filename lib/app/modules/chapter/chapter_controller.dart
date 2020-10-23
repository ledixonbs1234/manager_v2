import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/model/chapter_model.dart';
import 'package:manager_v2/app/modules/comic/model/comics_model.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
import 'package:manager_v2/app/modules/info/model/comic_info_model.dart';
import 'package:manager_v2/app/modules/read/read_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';
import 'package:manager_v2/app/tool.dart';

class ChapterViewModel {
  String name;
  double downloadCurrentValue;
  var isDownload = DownloadEnum.None.obs;

  ChapterViewModel({this.name});
}

enum DownloadEnum { None, Downloading, Completed, Error }

class ChapterController extends GetxController {
  final AllRespository respository;

  ChapterController({@required this.respository}) {
    printInfo(info: '******************************************89');
  }

  ///chapter from url
  var chapters = List<ChapterModel>();
  RxList<ChapterViewModel> chaptersView = List<ChapterViewModel>().obs;
  var currentChapter;

  ComicsModel comicsFile;
  ComicInfoModel comicFinded;
  ComicInfoModel comicOnlyInfo;

  loadingChapter(ComicInfoModel comic) async {
    this.comicsFile = Glob().getComicsFile();
    this.comicOnlyInfo = comic;

    comicFinded = getComicFromComicsFile();
    chapters = await respository.getChapterFromUrl(comicOnlyInfo.url);
    if  (comicFinded!= null)
      chapters = mapChaptersFileToChapters(chapters, comicFinded);
    convertChaptersToChaptersView();
  }

  ComicInfoModel getComicFromComicsFile() {
    if (comicsFile.comics == null) return null;
    //thuc hien kiem tra co comic trong nay khong
    var indexComicFinded = comicsFile.comics
        .indexWhere((element) => element.name == comicOnlyInfo.name);
    if (indexComicFinded == -1) return null;
    return comicsFile.comics[indexComicFinded];
  }

  downloadChapter(int index) async {
    chaptersView[index].isDownload(DownloadEnum.Downloading);
    chaptersView[index].downloadCurrentValue = 0;
    chaptersView.refresh();
    createComicFindIfNull();

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
    chapters[index].isDownloaded = true;
    chaptersView[index].isDownload(DownloadEnum.Completed);
    chaptersView.refresh();
    Get.snackbar(
        'Download Info', 'Download thanh cong ${chaptersView[index].name}');
    printInfo(info: 'Download xong chapter ${chapters[index].name}');

    comicFinded.chapters
        .removeWhere((element) => element.name == chapters[index].name);
    comicFinded.chapters.add(chapters[index]);

    comicsFile.comics
        .removeWhere((element) => element.name == comicFinded.name);
    comicsFile.comics.add(comicFinded);
    //update respository
    Glob().setComicsFile(comicsFile);

    //save comic to file
    var jsonOject = comicsFile.toJson();
    respository.saveComicToFile(jsonOject);
    printInfo(info: 'So luong chapter ${comicFinded.chapters.length}');
  }

  toReadPage(int index) {
    bool isDownloaded = false;
    if (chaptersView[index].isDownload.value == DownloadEnum.Completed) {
      var indexCurrent = comicFinded.chapters
          .indexWhere((element) => element.name == chaptersView[index].name);
      isDownloaded = true;

      currentChapter = comicFinded.chapters[indexCurrent];
    } else {
      isDownloaded = false;
      currentChapter = chapters[index];
    }

    var readC = Get.find<ReadController>();
    readC.loadingPage(currentChapter, isDownloaded);
    Get.toNamed(Routes.READ);
  }

  void convertChaptersToChaptersView() async {
    chaptersView.clear();
    for (var chapterv in chapters) {
      var chapterView = ChapterViewModel(name: chapterv.name);
      if (chapterv.isDownloaded) chapterView.isDownload(DownloadEnum.Completed);
      chaptersView.add(chapterView);
    }
  }

  List<ChapterModel> mapChaptersFileToChapters(
      List<ChapterModel> chapters, ComicInfoModel comicFinded) {
    //Liet ke cac chapter hien ra
    for (var chapter in comicFinded.chapters) {
      int index =
          chapters.indexWhere((element) => element.name == chapter.name);
      if (index != -1) {
        chapters[index] = chapter;
      }
    }
    return chapters
    ;
  }

  void createComicFindIfNull() {
    if (comicsFile.comics == null) {
      //add Comic to comicsFi
      comicsFile = ComicsModel();
      comicsFile.comics = List<ComicInfoModel>();
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
  }
}
