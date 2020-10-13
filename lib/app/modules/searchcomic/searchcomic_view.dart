import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/modules/searchcomic/searchcomic_controller.dart';

class SearchcomicView extends GetView<SearchcomicController> {
  @override
  Widget build(_) {
    controller.text = Get.find<ComicController>().text;
    controller.searchComic(controller.text);
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchcomicView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.comicsFinded.length == 0
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: controller.comicsFinded.length,
              itemBuilder: (BuildContext _, int index) {
                return ListTile(
                    onTap: () {
                      // controller.goSearchPage(controller.comicsFinded[index].url);
                      controller.goInfoPage(controller.comicsFinded[index].url);
                    },
                    title: Row(
                      children: [
                        Image.network(
                          controller.comicsFinded[index].imageUrl,
                          width: 80,
                          height: 110,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Text(
                                  controller.comicsFinded[index].name,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.comicsFinded[index].currentChapter,
                                  style: GoogleFonts.roboto(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ));
              })),
    );
  }
}
