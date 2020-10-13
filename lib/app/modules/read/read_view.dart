import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/modules/read/read_controller.dart';

class ReadView extends GetView<ReadController> {
  @override
  Widget build(BuildContext context) {
    controller.loadingPage(Get.find<ChapterController>().currentChapter);

    return Scaffold(
        appBar: AppBar(
          title: Text('ReadView'),
          centerTitle: true,
        ),
        body: Obx(() => controller.pages.length == 0
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: controller.pages.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title:
                        Image.file(File(controller.pages[index].urlRealpath)),
                  );
                },
              )));
  }
}
