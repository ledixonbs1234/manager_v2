import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/modules/comic/listview_truyendatai.dart';

class ComicView extends GetView<ComicController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('ComicView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: controller.searchComicController,
              onSubmitted: (text){
                //thuc hien nhap ban phim
                controller.goSearchPage(text);
              },

            ),
            Text('Truyen Da Download'),
            ListViewTruyenDaTai(controller: controller)
          ],
        ),
      ),
    );
  }
}
  