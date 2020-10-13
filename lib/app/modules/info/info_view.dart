import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';
import 'package:manager_v2/app/modules/searchcomic/searchcomic_controller.dart';

class InfoView extends GetView<InfoController> {
  @override
  Widget build(BuildContext context) {
    controller.infoLoading(Get.find<SearchcomicController>().urlComic);

    return Scaffold(
      appBar: AppBar(
        title: Text('InfoView'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.comic.value.name == null
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(controller.comic.value.urlImage),
                    Text(controller.comic.value.name),
                    Text(controller.comic.value.tacgia),
                    Text(controller.comic.value.luotXem),
                    Text(controller.comic.value.tinhTrang),
                    Text(controller.comic.value.noidung),
                    Text(controller.comic.value.urlDocTuDau),
                    Text(controller.comic.value.urlDocChapterCuoi),
                    FlatButton(onPressed: (){
                      controller.goChapterPage();
                    }, child: Text('chapter')),
                    FlatButton(onPressed: (){
                      controller.deleteFile();
                    }, child: Text('delete FileJson'))
                  ],
                ),
              ),
      ),
    );
  }
}
