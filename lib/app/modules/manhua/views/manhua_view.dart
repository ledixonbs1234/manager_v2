import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:manager_v2/app/modules/manhua/controllers/manhua_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ManhuaView extends GetView<ManhuaController> {
  String content = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';
  _lauch() async{
    const url = 'http://www.nettruyen.com/truyen-tranh/do-thi-phong-than/chap-146/646404';


    //
    // if(await canLaunch(url)){
    //   await launch(contentBase64);
    // }else{
    //   throw 'Can not launch $url';
    // }
  }
  @override
  Widget build(BuildContext context) {
    final String contentBase64 = base64Encode(const Utf8Encoder().convert(content));
    printInfo(info:'Manhua View Building');
    return Scaffold(
      appBar: AppBar(
        title: Text('ManhuaView'),
        centerTitle: true,
      ),
      body: WebView(initialUrl: 'data:text/html;base64,$contentBase64',),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        _lauch();

      },
    ),);
  }
}
