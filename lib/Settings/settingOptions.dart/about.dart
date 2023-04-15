// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:sizer/sizer.dart';

// ignore: use_key_in_widget_constructors
class about_ extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Widget Abouttext(String new_Text) {
    return Text(
      new_Text,
      style: TextStyle(color: S, fontStyle: FontStyle.italic, fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
    final _mediqaquey = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: S,
          ),
          color: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "About",
          style: TextStyle(color: S, fontWeight: FontWeight.bold),
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 100.h,
            width: 100.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [Colors.transparent, A])),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Abouttext("App Name : Elpida Musixcs"),
                      Abouttext("Version : 1"),
                      Abouttext("Developed By Midhunpu")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
