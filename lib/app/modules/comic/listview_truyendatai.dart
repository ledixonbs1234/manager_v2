import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';
import 'package:manager_v2/app/repository/all_respository.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

class ListViewTruyenDaTai extends StatelessWidget {
  final ComicController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    printInfo(info: 'ListViewTruyenDaTai Chay');
    return Container(
        width: Get.width,
        height: 210,
        child: Obx(() => controller.comicsFinded.value.comics != null
            ? ListView.builder(
                itemCount: controller.comicsFinded.value.comics.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  printInfo(info: 'Chay listView');
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.INFO);
                      var infoC = Get.find<InfoController>();
                      infoC.infoLoading(
                          controller.comicsFinded.value.comics[index].url);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 130,
                            height: 165,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                controller
                                    .comicsFinded.value.comics[index].urlImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                              controller.comicsFinded.value.comics[index].name,
                          style: GoogleFonts.muli(
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Container()));
  }
}
