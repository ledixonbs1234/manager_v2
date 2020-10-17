import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/model/comic_search_model.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

enum StateSearch{
  None,Loading,Completed
}

class SearchcomicController extends GetxController {
  final AllRespository respository;
  var state = StateSearch.None.obs;

  SearchcomicController({@required this.respository});
  String urlComic ;

  var comicsFinded = List<ComicSearchModel>().obs;

  searchComic(String text) async {
    state(StateSearch.Loading);
    var word = text.trim().toLowerCase();
    // comicsFinded.value = await respository.getComicFromText(word);
    comicsFinded.addAllNonNull(await respository.getComicFromText(word));
    printInfo(info: 'End SearchComic');
    state(StateSearch.Completed);
  }
  
  goInfoPage(String urlComic){
    this.urlComic = urlComic;
    Get.toNamed(Routes.INFO);
    var InfoC = Get.find<InfoController>();
    InfoC.infoLoading(urlComic);
  }
}
