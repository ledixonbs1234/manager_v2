import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

class ListViewTruyenDaTai extends StatelessWidget {
  final ComicController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    printInfo(info:'ListViewTruyenDaTai Chay');
    return Container(
        width: Get.width,
        color: Colors.white,
        child: Obx(() => controller.comicsFinded.value.comics != null
            ? Expanded(
              child: ListView.builder(
                  itemCount: controller.comicsFinded.value.comics.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    printInfo(info:'Chay listView');
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.INFO);
                        var infoC = Get.find<InfoController>();
                        infoC.infoLoading(controller.comicsFinded.value.comics[index].url);
                      },
                      child: Container(
                        color: Colors.lightBlue,
                        padding: EdgeInsets.all(10),
                        width: 100,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(controller.comicsFinded.value.comics[index].urlImage),
                            Text(controller.comicsFinded.value.comics[index].name),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            )
            : Container()));
  }
}
