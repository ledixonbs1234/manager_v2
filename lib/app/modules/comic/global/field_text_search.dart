import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../comic_controller.dart';

class fieldTextSearch extends GetView<ComicController> {

  const fieldTextSearch({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}