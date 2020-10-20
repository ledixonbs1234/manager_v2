import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_v2/app/modules/comic/global/field_text_search.dart';
import 'package:manager_v2/app/modules/searchcomic/searchcomic_controller.dart';

class SearchcomicView extends GetView<SearchcomicController> {
  @override
  Widget build(_) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 50,
              child: Material(
                elevation: 20,
                shadowColor: Colors.white,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                        BorderSide(color: Colors.white, width: 1.0)),
                    fillColor: Colors.white,
                    hintText: 'Search comic in here...',
                    prefixIcon: Center(
                      widthFactor: 1,
                      child: FaIcon(
                        FontAwesomeIcons.search,
                        color: Colors.blue,
                      ),
                    ),
                    // border: OutlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.indigoAccent))
                  ),
                  controller: controller.editTextC,
                  onSubmitted: (text) {
                    //thuc hien nhap ban phim
                    controller.searchComic(text);
                  },
                ),
              ),
            ),
            Obx(() => controller.state.value != StateSearch.None
                ? (controller.comicsFinded.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                            itemCount: controller.comicsFinded.length,
                            itemBuilder: (BuildContext _, int index) {
                              return ListTile(
                                  onTap: () {
                                    // controller.goSearchPage(controller.comicsFinded[index].url);
                                    controller.goInfoPage(
                                        controller.comicsFinded[index].url);
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
                                                controller
                                                    .comicsFinded[index].name,
                                                overflow: TextOverflow.fade,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                controller.comicsFinded[index]
                                                    .currentChapter,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                            }),
                      ))
                : Container())
          ],
        ),
      ),
    );
  }
}
