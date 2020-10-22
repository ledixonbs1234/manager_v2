import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/modules/comic/model/page_model.dart';
import 'package:manager_v2/app/modules/read/read_controller.dart';

class ReadView extends GetView<ReadController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ReadView'),
          centerTitle: true,
        ),
        body: Obx(() => !controller.isShow.value
            ? CircularProgressIndicator()
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: controller.pages
                    .map((page) => _imageCell(page))
                    .toList())));
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
