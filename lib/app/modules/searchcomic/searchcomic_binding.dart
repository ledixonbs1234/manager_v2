import 'package:get/get.dart';

import 'package:manager_v2/app/modules/searchcomic/searchcomic_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';

class SearchcomicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchcomicController>(
      () => SearchcomicController(respository: AllRespository()),
    );
  }
}
