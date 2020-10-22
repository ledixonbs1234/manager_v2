import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/modules/home/home_controller.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';
import 'package:manager_v2/app/modules/read/read_controller.dart';
import 'package:manager_v2/app/modules/searchcomic/searchcomic_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';

import 'app/routes/app_pages.dart';

void main() {
  var respository = AllRespository();
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => ComicController(respository: respository));
  Get.lazyPut(() => SearchcomicController(respository: respository));
  Get.lazyPut(() => InfoController(respository: respository));
  Get.lazyPut(() => ChapterController(respository: respository));
  Get.lazyPut(() => ReadController(respository: respository));

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
