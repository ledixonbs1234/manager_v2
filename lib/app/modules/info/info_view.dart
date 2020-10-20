import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';
import 'package:manager_v2/app/modules/searchcomic/searchcomic_controller.dart';

class InfoView extends GetView<InfoController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.comic.value.name == null
              ? CircularProgressIndicator()
              : CustomScrollView(slivers: [
                  SliverAppBar(
                    // backgroundColor: Colors.white,
                    floating: false,
                    pinned: true,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(controller.comic.value.name),
                      background: Image.network(
                        controller.comic.value.urlImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.code),
                        onPressed: () {
                          //chuyen sang mang hinh moi
                          controller.goChapterPage();
                        },
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 500,
                      width: Get.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          moduleRow(
                            "Tac gia",
                            controller.comic.value.tacgia,
                            "Tinh trang",
                            controller.comic.value.tinhTrang,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          moduleRow("Luot xem", controller.comic.value.luotXem,
                              "Name", controller.comic.value.name),
                          SizedBox(
                            height: 40,
                          ),
                          Text('Noi dung',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                              width: Get.width,
                              child:
                                  Text('  ' + controller.comic.value.noidung)),
                        ],
                      ),
                    ),
                  ),
                ]),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blueAccent,
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: Container(
            height: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            controller.goChapterPage();
          },
          child: FaIcon(
            FontAwesomeIcons.book,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Row moduleRow(String title1, String result1, String title2, String result2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [moduleInfo(title1, result1), moduleInfo(title2, result2)],
    );
  }

  Column moduleInfo(String title, String result) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          result,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          title,
          style: GoogleFonts.roboto(color: Colors.black38),
        )
      ],
    );
  }
}
