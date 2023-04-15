// ignore_for_file: no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/recentlyPlayed/Recently_Library.dart';

class recently_Played extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _mediaquery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Recently  Played",
            style: TextStyle(color: S),
          ),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: S,
              )),
          toolbarHeight: 50,
          backgroundColor: B,
        ),
        body: Container(
          height: _mediaquery.height * 1,
          color: B,
          width: _mediaquery.width,
          child: ListView(
            children: [recently_Libary()],
          ),
        ),
      ),
    );
  }
}
