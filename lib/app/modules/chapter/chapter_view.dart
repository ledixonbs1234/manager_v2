import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';

class ChapterView extends GetView<ChapterController> {
  @override
  Widget build(BuildContext context) {
    var infoController = Get.find<InfoController>();
    controller.loadingChapter(infoController.comic.value, infoController.comicsFi);
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
                    tileColor: controller.chaptersView[index].isDownloaded
                    ?Colors.blue
                    :Colors.amber,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.chapters[index].name),
                        Row(
                          children: [
                            FlatButton(
                                onPressed: () {
                                  controller.downloadChapter(index);
                                }, child: Text('Download')),
                            FlatButton(
                                onPressed: () {
                                  controller.toReadPage(index);
                                }, child: Text('Read'))
                          ],

                        )
                      ],
                    ));
              })),
    );
  }
}
