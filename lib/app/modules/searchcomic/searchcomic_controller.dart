import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/model/comic_search_model.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

class SearchcomicController extends GetxController {
  final AllRespository respository;

  SearchcomicController({@required this.respository});
  String urlComic ;

  String text = "";
  var comicsFinded = List<ComicSearchModel>().obs;

  searchComic(String text) async {
    var word = text.trim().toLowerCase();
    // comicsFinded.value = await respository.getComicFromText(word);
    comicsFinded.addAllNonNull(await respository.getComicFromText(word));
    printInfo(info: 'End SearchComic');
  }
  
  goInfoPage(String urlComic){
    this.urlComic = urlComic;
    Get.toNamed(Routes.INFO);
  }
}
