import 'package:get/get.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

class HomeController extends GetxController {
  goToComic(){
    Get.toNamed(Routes.COMIC);
  }
}
