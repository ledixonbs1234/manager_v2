import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_v2/app/modules/comic/comic_controller.dart';
import 'package:manager_v2/app/modules/comic/comic_view.dart';
import 'package:manager_v2/app/modules/home/home_controller.dart';
import 'package:manager_v2/app/modules/manhua/views/manhua_view.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Entertaiment',
            style: GoogleFonts.lora(
                fontSize: 25,
                color: Colors.indigoAccent.shade200,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2,
            crossAxisCount: 2,
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.blue,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 0))
                ]),
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    controller.goToComic();
                  },
                  child: Text('Manga',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.blue,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 0))
                ]),
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    controller.goToComic();
                  },
                  child: Text('Manhua',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              OpenContainer<bool>(closedBuilder: (context, action) {
                return Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.blue,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 0))
                  ]),
                  child: Center(
                    child: Text('Truyen Tranh',
                        style: GoogleFonts.roboto(color: Colors.white)),
                  ),
                );
              }, openBuilder: (context, action) {
                return ManhuaView();
              }),
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  controller.goToComic();
                },
                child: Text('Truyen Tranh',
                    style: GoogleFonts.roboto(color: Colors.white)),
              ),
            ],
          ),
        )
      ]),
    ));
  }
}
