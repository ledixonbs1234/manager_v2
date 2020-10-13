import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_v2/app/modules/comic/comic_view.dart';
import 'package:manager_v2/app/modules/home/home_controller.dart';
import 'package:manager_v2/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
        crossAxisCount: 2,

        children: [
          FlatButton(
            color: Colors.blue,
            onPressed: (){
              controller.goToComic();
            },
            child: Text('Truyen Tranh',style:GoogleFonts.roboto(color: Colors.white)),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color:Colors.grey,
            height: 10,
            child: Text('chao'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('chao'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('chao'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('chao'),
          )
        ],
      ),
    );
  }
}
  