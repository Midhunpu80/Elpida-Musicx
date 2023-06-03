// ignore_for_file: camel_case_types, avoid_unnecessary_containers, prefer_const_constructors, use_key_in_widget_constructors, file_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/HomePage/Reafactor/Homepage_reaFactor1.dart';
import 'package:music_player/HomePage/ALL_Songs_List.dart';
import 'package:music_player/Model/FavoriteModel/Favorite_Model.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

// ignore: unnecessary_new
OnAudioQuery audioQuery = new OnAudioQuery();
List<SongModel> startSong = [];

class Home_page1 extends StatefulWidget {
  @override
  State<Home_page1> createState() => _Home_page1State();
}

class _Home_page1State extends State<Home_page1> {
  ///List<SongModel> startSong = [];
  @override
  void initState() {
    super.initState();
    _permission();
  }

//////////////////for the permission //////////////////////////////
  _permission() async {
    dynamic perm = await audioQuery.permissionsStatus();
    if (!perm) {
      await audioQuery.permissionsRequest();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _mediaquery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 5, color: A),
            borderRadius: BorderRadius.circular(10)),
        child: Drawer(
          // ignore: sort_child_properties_last
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(200.h)),
                height: 20.h,
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset(
                      "images/mus15.jpg",
                      fit: BoxFit.cover,
                    ),
                    allTXT,
                    allTXT1
                  ],
                ),
              )
            ],
          ),
          width: 20.w,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: ListView(
        children: [
          ////////////appbar /////////////////
          Homescreen_appbar(
            20.h,
            40.w,
            B,
          ),

          const SizedBox(
            height: 20,
          ),

          ////////////// playlist and recent play     /////////////////////
          Playlist_and_mostplayed_icons(
              height2: 10.h,
              width2: 10.w,
              colors2: Colors.transparent,
              heiB: 10.h,
              widB: 28.w),

          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "All Songs ",
              style: TextStyle(
                  color: S, fontSize: 20, fontStyle: FontStyle.italic),
            ),
          ),

          const SizedBox(
            height: 5,
            width: 20,
          ),

          ////////////////////////////////////////////lsit of music///////
          FutureBuilder<List<SongModel>>(
            future: audioQuery.querySongs(
                sortType: null,
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true),
            builder: ((context, item) {
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (item.data!.isEmpty) {
                return Center(
                  child: Container(
                    child: Column(
                      children: [
                        Lottie.network(
                            "https://assets9.lottiefiles.com/packages/lf20_KOXhzYGQfb.json"),
                        Text(
                          "No Songs Found",
                          style: TextStyle(color: S, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                );
              }
              startSong = item.data!;
              // startS
              //staong = item.data!;
              if (!FavoriteDb.isInitialized) {
                FavoriteDb.initialize(item.data!);
              }

              return Column(
                children: [
                  Home_Music_Library(
                    songModel: item.data!,
                    height3: 9.h,
                    height45: 10.w,
                    width45: _mediaquery.width * 0.12,
                    color3: Colors.transparent,
                    width4: _mediaquery.width,
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
