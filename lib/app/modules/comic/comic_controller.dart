import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';


class ComicController extends GetxController {

  TextEditingController searchComicController = TextEditingController();
  String text;

  final AllRespository respository;
  ComicController({@required this.respository});



  goSearchPage(String text) {
    this.text = text;
    Get.toNamed(Routes.SEARCHCOMIC);
  }

}
