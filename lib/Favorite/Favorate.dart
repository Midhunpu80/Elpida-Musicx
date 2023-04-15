// ignore_for_file: camel_case_types, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Favorite/Favorite_Library.dart';

import 'package:music_player/HomePage/HomePage1.dart';
import 'package:music_player/Settings/settings.dart';
import 'package:sizer/sizer.dart';

class favorate extends StatelessWidget {
  const favorate({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => print("name"),
              icon: const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 255, 0, 0),
                size: 40,
              )),
          title: Text(
            "Favoraite ",
            style: TextStyle(color: S, fontSize: 25),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => settings());
                },
                icon: Icon(
                  Icons.settings,
                  color: A,
                  size: 40,
                ))
          ],
        ),
        body: Container(
          height: mediaquery.height,
          width: mediaquery.width,
          color: Colors.transparent,
          child: ListView(
            children: [
              ///////////////////////////////list//////////////////////
              const SizedBox(
                height: 20,
              ),

              Favorite_Library(70.h, 100.w)
            ],
          ),
        ),
      ),
    );
  }
}
