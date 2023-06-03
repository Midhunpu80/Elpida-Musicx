// ignore_for_file: prefer_const_constructors, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/mostlyPlayed/mostPlayed_Rea.dart';

class Mostly_Played extends StatelessWidget {
  const Mostly_Played({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    var _mediaquery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          shadowColor: Color.fromARGB(255, 255, 0, 85),
          centerTitle: true,
          title: Text(
            "Mostly Played",
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
          height: _mediaquery.height,
          
          width: _mediaquery.width,
          child: ListView(
            children: [Mostly_Libary()],
          ),
        ),
      ),
    );
  }
}
