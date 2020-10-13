import 'package:get/get.dart';

import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';

class ChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChapterController>(
      () => ChapterController(respository: AllRespository()),
    );
  }
}
