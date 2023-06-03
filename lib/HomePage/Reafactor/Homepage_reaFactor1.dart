// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers, use_key_in_widget_constructors, camel_case_types, must_be_immutable, file_names, prefer_const_constructors, prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';

import 'package:music_player/Settings/settings.dart';
import 'package:music_player/mostlyPlayed/mostlyPlayed.dart';
import 'package:music_player/newPLayList/PlayList.dart';

import 'package:music_player/recentlyPlayed/recently_Played.dart';
import 'package:sizer/sizer.dart';

//--------------------------APPBAR--------------------------------------------//
////////////////////////////////////////////////////////////////////////////////

class Homescreen_appbar extends StatelessWidget {
  double? height1;
  double? width1;
  Color? color1;
  Homescreen_appbar(this.height1, this.width1, this.color1);

  @override
  Widget build(BuildContext context) {
    return Container(
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

          // icon_Button1(Icons.menu, settings(), context),
          Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: A,
                        // ignore: prefer_const_constructors
                        offset: Offset(1.0, 1.0),
                        blurRadius: 10,
                        spreadRadius: 4)
                  ],
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 3,
                    color: B,
                  )),
              child: const CircleAvatar(
                radius: 34,
                backgroundImage: AssetImage(
                  "images/mus15.jpg",
                ),
              ),
            ),
          ),
          Icon_Button1(Icons.settings, settings(), context)
        ],
      ),
    );
  }

  Widget Icon_Button1(dynamic reaIocon, Screen_nav, BuildContext context) {
    // ignore: avoid_print
    return IconButton(
      onPressed: () => Get.to(Screen_nav),
      icon: Icon(reaIocon),
      color: A,
      iconSize: 40,
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

/////////////////////////////SCROLL VIEW ///////////////////////////////////////

Playlist_and_mostplayed_icons(
    {required double height2,
    required double width2,
    required Color colors2,
    required double heiB,
    required double widB}) {
  return Container(
    height: height2,
    width: width2,
    color: colors2,
    child: Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          levatedbutton1(
            icon3: Icons.playlist_add_check,
            button_name1: "PlayList",
            button_Colors1: A,
            heightA: heiB,
            widthA: widB,
            n_av: play_List(),
          ),
          levatedbutton1(
            icon3: Icons.more_time_sharp,
            button_name1: "Mostly Played",
            button_Colors1: A,
            heightA: heiB,
            widthA: widB,
            n_av: Mostly_Played(),
          ),
          levatedbutton1(
            icon3: Icons.timelapse_sharp,
            button_name1: "Recently Played",
            button_Colors1: A,
            heightA: heiB,
            widthA: widB,
            n_av: recently_Played(),
          ),
        ],
      ),
    ),
  );
}

class levatedbutton1 extends StatelessWidget {
  var icon3;
  String button_name1;
  // ignore: non_constant_identifier_names
  Color button_Colors1;
  double heightA;
  double widthA;
  var n_av;

  levatedbutton1(
      {super.key,
      required this.icon3,
      required this.button_name1,
      required this.button_Colors1,
      required this.heightA,
      required this.widthA,
      // ignore: empty_constructor_bodies
      required this.n_av}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: heightA,
      width: widthA,
      child: GestureDetector(
        child: ButtonTheme(
          height: heightA,
          minWidth: widthA,
          child: ElevatedButton.icon(
              onPressed: () => Get.to(n_av),
              icon: Icon(
                icon3,
                color: Colors.white,
              ),
              label: Text(button_name1,
                  style: TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.fade,
                      fontSize: 7.sp)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: button_Colors1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////list of the music//////////////////////

