import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/modules/comic/global/field_text_search.dart';
import 'package:manager_v2/app/modules/comic/listview_truyendatai.dart';

class ComicView extends GetView<ComicController> {
  const ComicView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              fieldTextSearch(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Truyen Da Download',
                  style: GoogleFonts.sansita(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.lightBlue.shade700),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListViewTruyenDaTai()
            ],
          ),
        ),
      ),
    );
  }
}
