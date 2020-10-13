import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_v2/app/modules/comic/comic_controller.dart';

class ListViewTruyenDaTai extends GetView {
  var controller;
  ListViewTruyenDaTai({@required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2000,
      height: 100,
      color: Colors.blue,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_,index){
          return Title(

            color: Colors.white,
            child: Text('chao'),
          );
        },
      ),
    );
  }
}
  