// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Settings/settings.dart';

////////////////////////////////////////////navbar ////////////////////
class Serch_appbar extends StatelessWidget {
  double sheight1;
  double swidth1;
  dynamic scolor1;
  var nav_factor1;
  Serch_appbar(
      {super.key,
      required this.sheight1,
      // required this.nav_factor1,
      required this.scolor1,
      required this.swidth1});
  // required double sheight,
  // required double swidht}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sheight1,
      width: swidth1,
      color: scolor1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: A,
                    size: 40,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          Text(
            "Search",
            style:
                TextStyle(color: S, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          sicon_Button1(Icons.settings, context),
        ],
      ),
    );
  }

  Widget sicon_Button1(var sreaIocon, BuildContext context) {
    // ignore: avoid_print
    return IconButton(
      onPressed: () => Get.to(settings()),
      icon: Icon(sreaIocon),
      color: A,
      iconSize: 40,
    );
  }
}
