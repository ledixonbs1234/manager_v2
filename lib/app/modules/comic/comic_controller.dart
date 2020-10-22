import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/model/comics_model.dart';
import 'package:manager_v2/app/modules/searchcomic/searchcomic_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';
import 'package:manager_v2/app/tool.dart';

enum StateComic { None, Loading, Completed }

class ComicController extends GetxController {
  TextEditingController editTextC = TextEditingController();
  String text;
  var state = StateComic.None.obs;
  var focusNode = FocusNode().obs;

  final AllRespository respository;
  var comicsFinded = ComicsModel().obs;
  ComicController({@required this.respository});

  loadingPage() async {

    //thuc hien get truyen
    comicsFinded(await respository.getComicsFromJson());
    Glob().setComicsFile(comicsFinded.value);
    if (comicsFinded == null) {}
  }

  goSearchPage(String text) {
    focusNode.value.unfocus();
    printInfo(info: 'GoSearchPage Mehthod');
    Get.toNamed(Routes.SEARCHCOMIC);
    SearchcomicController searchController = Get.find();
    if(text != null) {
      searchController.state.value = StateSearch.Loading;
      searchController.searchComic(text);
    }
  }
}
