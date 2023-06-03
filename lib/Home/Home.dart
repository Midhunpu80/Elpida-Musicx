// ignore_for_file: non_constant_identifier_names, file_names, prefer_final_fields, use_key_in_widget_constructors, unused_local_variable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Favorite/Favorate.dart';
import 'package:music_player/Home/mini_Player.dart';
import 'package:music_player/HomePage/HomePage1.dart';
import 'package:music_player/Model/dbfunction/Recently_PlayedDb.dart';
import 'package:music_player/Music_PLaying_Screen/Now_play.dart';
import 'package:music_player/Serch.dart/serchPage1.dart';
import 'package:music_player/Settings/Settings.dart';
import 'package:music_player/controllers/control.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic _index = 0;

  // ignore: prefer_const_constructors
  List _pages = [Home_page1(), serch_Page1(), favorate(), settings()];

  BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    var media_query = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar:
          Column(mainAxisSize: MainAxisSize.min, children: const [
/////////////////////////////////////////////////mini player /////////////////////////////
      ]),
      body: GetBuilder<BottomNavController>(builder: (context) {
        return ValueListenableBuilder(
            valueListenable: GetRecentlyPlayed.recentSongNotifier,
            builder: (context, List<SongModel> item, Widget? child) {
              return Stack(
                children: [
                  _pages[bottomNavController._currentIndex],
                  Padding(
                      padding: EdgeInsets.only(top: 80.h),
                      child: Column(
                        children: [
                          item.isEmpty
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    NowPlaying(
                                      songModel:
                                          GetAllSongController.playingsong,
                                      count: GetAllSongController
                                          .playingsong.length,
                                    );
                                  },
                                  child: InkWell(
                                      onTap: () {
                                        Get.to(NowPlaying(
                                          songModel:
                                              GetAllSongController.playingsong,
                                          count: GetAllSongController
                                              .playingsong.length,
                                        ));
                                      },
                                      child: mini_Player()))
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 90.h),
                    child: CurvedNavigationBar(
                        backgroundColor: B,
                        index: _index,
                        buttonBackgroundColor: Colors.white,
                        onTap: (value) => setState(() {
                              _index = value;

                              bottomNavController._currentIndex = _index;
                            }),
                        color: S,
                        height: 50,
                        items: [
                          Icon(
                            Icons.home,
                            color: B,
                            size: 28,
                            semanticLabel: "Home",
                          ),
                          Icon(
                            Icons.search,
                            color: B,
                            size: 28,
                          ),
                          Icon(
                            Icons.favorite,
                            color: B,
                            size: 28,
                          ),
                          Icon(
                            Icons.settings,
                            size: 28,
                            color: B,
                          )
                        ]),
                  ),
                ],
              );
            });
      }),
    ));
  }
}

class BottomNavController extends GetxController {
  int _currentIndex = 0;
  get currentIndex => _currentIndex;
  set currentIndex(index) {
    _currentIndex = index;
    update();
  }
}
