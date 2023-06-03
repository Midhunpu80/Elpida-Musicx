// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Settings/settingOptions.dart/Share.dart';
import 'package:music_player/Settings/settingOptions.dart/about.dart';
import 'package:music_player/Settings/settingOptions.dart/privacyPolicy.dart';
import 'package:music_player/Settings/settingOptions.dart/termCondtions.dart';
import 'package:music_player/Settings/settingOptions.dart/themes.dart';
import 'package:music_player/Splash/Splash.dart';

import 'package:sizer/sizer.dart';

// ignore: use_key_in_widget_constructors
class settings extends StatelessWidget {
  final List Name_of_Setting = [
    "About",
    "Themes",
    "privacy&Policy",
    "Terms&Conditions",
    "share"
  ];
  final List Nav_of_Setting = [
    about_(),
    The_mes(),
    privacy_Policy(),
    terms_conditions(),
    Sharedscreen()
  ];

  @override
  Widget build(BuildContext context) {
    var _mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 5.h,
        title: Text(
          "Settings",
          style: TextStyle(color: S),
        ),
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: S,
              )),
        ),
        actions: [
          GestureDetector(
              child: IconButton(
                  splashColor: S,
                  splashRadius: 50.0,
                  onPressed: () => print("name"),
                  icon: Icon(
                    Icons.settings,
                    color: S,
                  )))
        ],
      ),
      body: Container(
          color: Colors.transparent,
          width: _mediaquery.width,
          height: _mediaquery.height,
          child: ListView.separated(
              itemBuilder: ((context, index) {
                return Card(
                  shape: const StadiumBorder(),
                  shadowColor: A,
                  color: B,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: B,
                    ),
                    margin: const EdgeInsets.only(left: 2, right: 2),
                    child: ListTile(
                      onTap: () {
                        Get.to(Nav_of_Setting[index]);
                      },
                      title: Text(
                        (Name_of_Setting[index]),
                        selectionColor: Colors.pink,
                        style: TextStyle(
                          color: S,
                        ),
                      ),
                      trailing: IconButton(
                          splashColor: Color.fromARGB(255, 0, 255, 8),
                          onPressed: () => Get.to(Nav_of_Setting[index]),
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: S,
                          )),
                    ),
                  ),
                );
              }),
              separatorBuilder: ((context, index) {
                return const SizedBox(
                  height: 20,
                );
              }),
              itemCount: Name_of_Setting.length)),
    );
  }
}
