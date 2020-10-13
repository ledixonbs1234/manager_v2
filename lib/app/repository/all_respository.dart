import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:manager_v2/app/modules/comic/model/chapter_model.dart';
import 'package:manager_v2/app/modules/comic/model/comic_search_model.dart';
import 'package:manager_v2/app/modules/comic/model/comics_model.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
import 'package:manager_v2/app/modules/info/model/comic_info_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity/connectivity.dart';

class AllRespository {
  final Dio _dio = Dio();

  Future<bool> isNetwork() async {
    var connectResult = await Connectivity().checkConnectivity();
    if (connectResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  Future<List<ComicSearchModel>> getComicFromText(String text) async {
    //Thuc hien lenh trong nay
    var textCross = text.replaceAll(' ', '+');
    var urlPrepage =
        'http://www.nettruyen.com/Comic/Services/SuggestSearch.ashx?q=';
    var url = urlPrepage + textCross;

    var document = await getDocumentWeb(url);
    if (document == null) {
      return null;
    }
    var elements = document.getElementsByTagName('li');
    if (elements.length == 0) {
      return null;
    }

    var comics = List<ComicSearchModel>();
    elements.forEach((element) {
      String name = element.getElementsByTagName('h3')[0].text;
      var imageUrl = 'http://' +
          element
              .getElementsByTagName('img')[0]
              .attributes['src']
              .replaceFirst('//', '');
      var url = element.getElementsByTagName('a')[0].attributes['href'];
      var currentChapter = element.getElementsByTagName('i')[0].text;
      ComicSearchModel comic = ComicSearchModel(
          name: name,
          url: url,
          imageUrl: imageUrl,
          currentChapter: currentChapter);
      comics.add(comic);
    });
    return comics;
  }

  Future<Document> getDocumentWeb(String url) async {
    final response = await _dio.getUri(Uri.parse(url));

    if (response.statusCode != 200) {
      printError(info:"Loi mang ${response.statusCode}");
      return null;
    }
    return parse(response.data);
  }

  Future<List<ChapterModel>> getChapterFromUrl(String url) async {
    Document document = await getDocumentWeb(url);
    if (document == null) return null;
    var chaptersDo = document.getElementsByClassName('chapter');
    var chapters = List<ChapterModel>();
    var nameComic = document.getElementsByClassName('title-detail')[0].text;
    chaptersDo.forEach((element) {
      var child = element.getElementsByTagName('a')[0];
      String nameChapter = child.text;
      String urlChapter = child.attributes['href'];
      //var date = child.nextElementSibling;
      ChapterModel chapter = ChapterModel(
          name: nameChapter,
          url: urlChapter,
          date: 'nothing',
          nameComic: nameComic);
      chapters.add(chapter);
    });
    return chapters;
  }

  prefixUrl(String url) {
    String newUrl = url.substring(url.indexOf('//') + 2);
    return 'https://' + newUrl;
  }

  String checkNameUrl(String url, int count) {
    if (url.indexOf('.jpg') >= 0)
      return 'image' + count.toString() + '.jpg';
    else if (url.indexOf('png') >= 0)
      return 'image' + count.toString() + '.png';
    else
      return 'image' + count.toString() + '.jpg';
  }

  Future<Directory> createFolderInManga(String name) async {
    var pathManga = await getRealPathManga();
    return await Directory('$pathManga/$name').create(recursive: true);
  }

  Future<String> getRealPathManga() async {
    Directory folder = await getExternalStorageDirectory();
    var nameManga = 'Manga';
    var folderManga = Directory('${folder.path}/$nameManga');
    bool isExist = await folderManga.exists();
    //Kiem tra su ton tai file
    if (!isExist) await folderManga.create(recursive: true);
    return folderManga.path;
  }

  checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      await Permission.storage.request();
    }
  }

  Future<List<String>> getUrlImageFromUrlChapter(String urlChapter) async {
    var document = await getDocumentWeb(urlChapter);
    var chaptersDo = document.getElementsByClassName('page-chapter');
    List<String> urlImages = List<String>();
    chaptersDo.forEach((element) {
      String src = element.getElementsByTagName('img')[0].attributes['src'];
      src = prefixUrl(src);
      urlImages.add(src);
    });
    return urlImages;
  }

  downloadChapter(ChapterModel chapter, callback) async {
    await checkPermission();

    var urlImages = await getUrlImageFromUrlChapter(chapter.url);
    String progress = "";
    var folder = await createFolderInManga(chapter.nameComic);
    var dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) {
      options.headers['referer'] = 'nettruyen';
    }));
    var count = 1;
    var futures = <Future>[];

    for (var urlImage in urlImages) {
      var nameImage = checkNameUrl(urlImage, count);
      var urlRealPath = "${folder.path}/$nameImage";
      count++;
      var page = PageModel(index:count,
          name: nameImage, urlPath: urlImage, urlRealpath: urlRealPath);

      try {
        futures.add(dio.download(
          urlImage,
          urlRealPath,
          onReceiveProgress: (receibyte, totalByte) {
            var progress = ((receibyte / totalByte) * 100);
          },
          queryParameters: {'referer':'http://www.nettruyen.com/'}
        ).then((d) => callback(page)).catchError((e)=>Get.snackbar('title', 'Loi $e')));
      } catch (e) {
        Get.snackbar('tieu de', e.toString());
      }
    }
    await Future.wait(futures);
  }

  Future<ComicInfoModel> getInfoComic(String urlComic) async {
    Document document = await getDocumentWeb(urlComic);
    if (document == null) return null;
    var rawUrlImage = document
        .getElementsByClassName('col-xs-4 col-image')[0]
        .getElementsByTagName('img')[0]
        .attributes['src'];
    var urlImage = prefixUrl(rawUrlImage);
    var name = document.getElementsByClassName('title-detail')[0].text;
    var author =
        document.getElementsByClassName('author row')[0].children.last.text;
    var tinhtrang =
        document.getElementsByClassName('status row')[0].children.last.text;
    var luotxem = document
        .getElementsByClassName('list-info')[0]
        .children
        .last
        .children
        .last
        .text;
    var noidung =
        document.getElementsByClassName('detail-content')[0].children.last.text;
    // var documentReadButton = document
    //     .getElementsByClassName('read-action mrt10')[0];
    // var urlDocTuDau = documentReadButton
    //     .children[0]
    //     .attributes['href'];
    // if (documentReadButton.children.)
    // var urlDocChapCuoi = document
    //     .getElementsByClassName('read-action mrt10')[0]
    //     .children[1]
    //     .attributes['href'];

    return ComicInfoModel(
        url: urlComic,
        urlImage: urlImage,
        name: name,
        tacgia: author,
        luotXem: luotxem,
        tinhTrang: tinhtrang,
        noidung: noidung,
        urlDocTuDau: 'urlChapDau',
        urlDocChapterCuoi: 'urlChapte cuoi');
  }

  Future<ComicsModel> getComicsFromJson() async {
    var nameFile = 'listComicManga.json';
    var pathFolder = await getRealPathManga();
    String contentJson = await _getContentFile(pathFolder, nameFile);
    if (contentJson == null) {
      return null;
    }
    Map<String, dynamic> dataJson = jsonDecode(contentJson);
    var comics = ComicsModel.fromJson(dataJson);
    return comics;
  }

  deleteFileJson()async{
    var nameFile = 'listComicManga.json';
    var pathFolder = await getRealPathManga();
    File('$pathFolder/$nameFile').delete(recursive: true);
  }

  Future<String> _getContentFile(String pathFolder, String nameFile) async {
    var file = File(pathFolder + '/' + nameFile);
    bool isExist = await file.exists();
    try {
      if (isExist) return file.readAsStringSync();
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveComicToFile(Map<String,dynamic> jsonObject) async{
    var nameFile = 'listComicManga.json';
    var pathFolder = await getRealPathManga();
    var isWrited = await  writeTextToFile(pathFolder, nameFile, jsonEncode(jsonObject));
    if(isWrited){
      return true;
    }
    return false;

  }
 Future<bool> writeTextToFile(String pathFolder,String filename,String content)async{
    try{
      await File('$pathFolder/$filename').writeAsString(content,mode: FileMode.write);
      return true;
    }catch(e){
      return false;
    }
  }
}
