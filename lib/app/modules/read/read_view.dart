import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
import 'package:manager_v2/app/modules/read/read_controller.dart';

class ReadView extends GetView<ReadController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(controller.chapter.value.name)),
          centerTitle: true,
        ),
        floatingActionButton: Obx(
          () => Visibility(
            visible: controller.isShowFLoat.value,
            child: FabCircularMenu(
              fabOpenIcon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              fabCloseIcon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onDisplayChange: (value) {
                if (!value) {
                  controller.isShowFLoat(false);
                } else {
                  controller.isShowFLoat(true);
                }
              },
              alignment: Alignment.bottomLeft,
              fabColor: Colors.black12,
              key: controller.fabkey,
              ringColor: Colors.blue.withOpacity(0.5),
              children: [
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.arrowRight,
                      color: Colors.white,
                    ),onPressed: (){
                      controller.toNextPage();
                      controller.isShowFLoat(false);

                },),
                IconButton(
                    icon:
                        FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white),
                    onPressed: () {
                      controller.toPrevousPage();
                      controller.isShowFLoat(false);
                    }),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.arrowCircleLeft,
                        color: Colors.white),
                    onPressed: () {
                      Get.back();
                    })
              ],
            ),
          ),
        ),
        body: GestureDetector(
          onLongPress: () {
            if (!controller.isShowFLoat.value) {
              controller.isShowFLoat(true);
            } else {
              controller.isShowFLoat(false);
            }
          },
          child: Obx(() => !controller.isShow.value
              ? CircularProgressIndicator()
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: controller.pages
                      .map((page) => _imageCell(page))
                      .toList())),
        ));
  }

  Widget _imageCell(PageModel imageUrl) {
    return ListTile(
        title: controller.isDownloaded.value
            ? Image.file(File(imageUrl.urlRealpath))
            : CachedNetworkImage(
                imageUrl: imageUrl.urlPath,
                httpHeaders: {'referer': 'nettruyen'},
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ));
  }
}
