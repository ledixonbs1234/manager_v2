import 'package:get/get.dart';

import 'package:manager_v2/app/modules/read/read_controller.dart';

class ReadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadController>(
      () => ReadController(),
    );
  }
}
