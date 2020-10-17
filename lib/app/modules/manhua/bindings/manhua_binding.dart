import 'package:get/get.dart';

import 'package:manager_v2/app/modules/manhua/controllers/manhua_controller.dart';

class ManhuaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManhuaController>(
      () => ManhuaController(),
    );
  }
}
