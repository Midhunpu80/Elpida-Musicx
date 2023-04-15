// ignore_for_file: use_key_in_widget_constructors, camel_case_types, no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';

import 'package:music_player/Model/PlayList_Db/PLayList_Db.dart';
import 'package:music_player/NewDb/Music_Model.dart';

import 'package:music_player/Settings/settings.dart';

import 'package:music_player/newPLayList/Create_PLaylist.dart';
import 'package:music_player/newPLayList/PlayList_Library.dart';
import 'package:sizer/sizer.dart';

class play_List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlaylistDb.getAllPlaylist();

    var _mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 255, 0, 85),
        title: Text(
          "PlayList",
          style: TextStyle(color: S),
        ),
        centerTitle: true,
        toolbarHeight: 6.h,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: S)),
        actions: [
          IconButton(
              onPressed: () => Get.to(settings()),
              icon: Icon(
                Icons.settings,
                color: S,
              ))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: PlaylistDb.playlistNotifier,
          builder: (context, List<Music_Model> musiclist, Widget? child) {
            return Container(
              height: _mediaquery.height,
              width: _mediaquery.width,
              color: Colors.transparent,
              child: ListView(
                children: [
                  Add_playList(),
                  const SizedBox(
                    height: 10,
                  ),
                  musiclist.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Center(
                            child: Text(
                              "Create  New playList",
                              style: TextStyle(fontSize: 15, color: S),
                            ),
                          ),
                        )
                      : //////////////////////////////////////////music list
                      playList_Libary(
                          Playlistpay: musiclist,
                          Pheight3: _mediaquery.height * 0.9,
                          Pheight45: _mediaquery.height * 0.11,
                          Pwidth45: _mediaquery.width * 0.11,
                          Pcolor3: Colors.transparent,
                          Pwidth4: _mediaquery.width)
                  // playList_rea2(),
                  // playList_Rea3()
                ],
              ),
            );
          }),
    );
  }
}
