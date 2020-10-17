import 'package:manager_v2/app/modules/manhua/views/manhua_view.dart';
import 'package:manager_v2/app/modules/manhua/bindings/manhua_binding.dart';
import 'package:manager_v2/app/modules/read/read_view.dart';
import 'package:manager_v2/app/modules/read/read_binding.dart';
import 'package:manager_v2/app/modules/chapter/chapter_view.dart';
import 'package:manager_v2/app/modules/chapter/chapter_binding.dart';
import 'package:manager_v2/app/modules/info/info_binding.dart';
import 'package:manager_v2/app/modules/info/info_view.dart';
import 'package:manager_v2/app/modules/searchcomic/searchcomic_view.dart';
import 'package:manager_v2/app/modules/searchcomic/searchcomic_binding.dart';
import 'package:manager_v2/app/modules/comic/comic_view.dart';
import 'package:manager_v2/app/modules/comic/comic_binding.dart';
import 'package:manager_v2/app/modules/home/home_view.dart';
import 'package:manager_v2/app/modules/home/home_binding.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  
static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME, 
      page:()=> HomeView(), 
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.COMIC, 
      page:()=> ComicView(

      ),
      binding: ComicBinding(),
    ),
    GetPage(
      name: Routes.SEARCHCOMIC, 
      page:()=> SearchcomicView(), 
      binding: SearchcomicBinding(),
    ),
    GetPage(
      name: Routes.INFO, 
      page:()=> InfoView(), 
      binding: InfoBinding(),
    ),
    GetPage(
      name: Routes.CHAPTER, 
      page:()=> ChapterView(), 
      binding: ChapterBinding(),
    ),
    GetPage(
      name: Routes.READ, 
      page:()=> ReadView(), 
      binding: ReadBinding(),
    ),
    GetPage(
      name: Routes.MANHUA, 
      page:()=> ManhuaView(), 
      binding: ManhuaBinding(),
    ),
  ];
}