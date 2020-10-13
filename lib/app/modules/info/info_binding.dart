import 'package:get/get.dart';

import 'package:manager_v2/app/modules/info/info_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';

class InfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoController>(
      () => InfoController(respository: AllRespository()),
    );
  }
}
