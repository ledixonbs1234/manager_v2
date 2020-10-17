import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/modules/comic/listview_truyendatai.dart';

class ComicView extends GetView<ComicController> {
  const ComicView({Key key}) : super(key: key);

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
            Container(
              margin: EdgeInsets.all(20),
              height: 50,
              child: Material(
                elevation: 20,
                shadowColor: Colors.white,
                child: TextField(
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
                    controller.goSearchPage(text);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Truyen Da Download',
              style: GoogleFonts.lora(fontWeight: FontWeight.bold,
              fontSize: 16,color: Colors.lightBlue.shade700),),
            ),
            ListViewTruyenDaTai()
          ],
        ),
      ),
    );
  }
}
