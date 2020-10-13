import 'package:get/get.dart';

import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';

class ComicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComicController>(
      () => ComicController(respository: AllRespository()),
    );
  }
}
