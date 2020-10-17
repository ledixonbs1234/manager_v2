import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';

class ChapterView extends GetView<ChapterController> {
  @override
  Widget build(BuildContext context) {
    var infoController = Get.find<InfoController>();
    controller.loadingChapter(
        infoController.comic.value, infoController.comicsFi);
    return Scaffold(
      appBar: AppBar(
        title: Text('ChapterView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.chaptersView.length == 0
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: controller.chaptersView.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onTap: () {},
                    title: Container(
                      height: 60,
                      // margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      padding: controller
                                  .chaptersView[index].isDownload.value ==
                              DownloadEnum.Downloading
                          ? EdgeInsets.zero
                          : EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                          color:
                              controller.chaptersView[index].isDownload.value ==
                                      DownloadEnum.Completed
                                  ? Colors.blue
                                  : Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: controller.chaptersView[index].isDownload.value ==
                              DownloadEnum.Downloading
                          ? LiquidLinearProgressIndicator(
                              value: controller
                                  .chaptersView[index].downloadCurrentValue,
                              valueColor: AlwaysStoppedAnimation(Colors.pink),
                              backgroundColor: Colors.white,
                              borderColor: Colors.blue,
                              borderRadius: 12,
                              borderWidth: 1,
                              direction: Axis.horizontal,
                              center: Text(
                                '${controller.chaptersView[index].name}',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold),
                              ))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.chapters[index].name),
                                Row(
                                  children: [
                                    FlatButton(
                                        onPressed: () {
                                          controller.downloadChapter(index);
                                        },
                                        child: Text('Download')),
                                    FlatButton(
                                        onPressed: () {
                                          controller.toReadPage(index);
                                        },
                                        child: Text('Read'))
                                  ],
                                )
                              ],
                            ),
                    ));
              })),
    );
  }
}
