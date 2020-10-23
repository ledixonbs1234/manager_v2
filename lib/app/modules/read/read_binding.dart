import 'package:get/get.dart';

import 'package:manager_v2/app/modules/read/read_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';

class ReadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadController>(
      () => ReadController(respository: AllRespository()),
    );
  }
}
