import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:manager_v2/app/modules/chapter/chapter_controller.dart';
import 'package:manager_v2/app/modules/info/info_controller.dart';

class ChapterView extends GetView<ChapterController> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Obx(() => controller.chaptersView.length == 0
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: controller.chaptersView.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildchildListView(index);
                })),
      ),
    );
  }

  ListTile buildchildListView(int index) {
    return ListTile(
        onTap: () {},
        title: Container(
          margin: EdgeInsets.only(top: 5),
          height: 95,
          // margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                color: Colors.blue,
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
            color: Colors.white,
          ),
          child: buildNormalChapter(index),
        ));
  }

  Row buildNormalChapter(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Container(
            alignment: Alignment.center,
            width: 70,
            height: 95,
            color: controller.chaptersView[index].isDownload.value ==
                    DownloadEnum.Downloading
                ? Colors.redAccent
                : controller.chaptersView[index].isDownload.value ==
                        DownloadEnum.Completed
                    ? Colors.blue
                    : Colors.green,
            child: controller.chaptersView[index].isDownload.value ==
                    DownloadEnum.Downloading
                ? buildAnimationDownloading(index)
                : controller.chaptersView[index].isDownload.value ==
                        DownloadEnum.Completed
                    ? FaIcon(
                        FontAwesomeIcons.laptop,
                        color: Colors.white30,
                        size: 40,
                      )
                    : FaIcon(
                        FontAwesomeIcons.book,
                        color: Colors.white30,
                        size: 40,
                      ))),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    AutoSizeText(
                      controller.chapters[index].name,
                      maxLines: 1,
                      softWrap: true,
                      minFontSize: 10,
                      style: GoogleFonts.roboto(color: Colors.blue),
                    ),
                    Text(controller.chapters[index].date)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(children: [
                  Text(
                        'Luot xem : ',
                    style: GoogleFonts.roboto(color: Colors.black26),
                  ),
                  Text(controller.chapters[index].luotXem==null?"Chao":controller.chapters[index].luotXem),
                ]),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 30,
                        child: FlatButton(
                          color: Colors.white30,
                          onPressed: () {
                            controller.toReadPage(index);
                          },
                          child: FaIcon(
                            FontAwesomeIcons.eye,
                            color: Colors.deepOrangeAccent,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 30,
                        child: FlatButton(
                          color: Colors.white30,
                          onPressed: () {
                            controller.downloadChapter(index);
                          },
                          child: FaIcon(
                            FontAwesomeIcons.download,
                            color: Colors.deepPurpleAccent,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Container buildAnimationDownloading(int index) {
    return Container(
        width: 60,
        height: 60,
        child: LiquidCircularProgressIndicator(
          value: controller.chaptersView[index].downloadCurrentValue,
          // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(Colors.redAccent),
          // Defaults to the current Theme's accentColor.
          backgroundColor: Colors.white,
          // Defaults to the current Theme's backgroundColor.
          borderColor: Colors.red,
          borderWidth: 0,
          direction: Axis.vertical,
          // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
          center: Text(
              "${(controller.chaptersView[index].downloadCurrentValue * 100).toStringAsFixed(0)} %",
              style: GoogleFonts.roboto(
                  color: Colors.indigo, fontWeight: FontWeight.bold)),
        ));
  }
}
