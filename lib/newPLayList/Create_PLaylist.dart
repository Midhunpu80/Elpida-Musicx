// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors, duplicate_ignore, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';

import 'package:music_player/Model/PlayList_Db/PLayList_Db.dart';
import 'package:music_player/NewDb/Music_Model.dart';

import 'package:sizer/sizer.dart';

// ignore: use_key_in_widget_constructors
class Add_playList extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final Playlist_control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PlaylistDb.getAllPlaylist();
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          child: OutlinedButton.icon(
            onPressed: () {
              alertBox(context); // ignore: avoid_print
              print("name");
            },
            style: OutlinedButton.styleFrom(disabledBackgroundColor: S),
            icon: const Icon(Icons.add),
            label: const Text("Add Musics TO the playlist"),
          )),
    );
  }

  static void alertBox(BuildContext context) {
    final Playlist_control = TextEditingController();
    showDialog(
        barrierColor: const Color.fromARGB(139, 158, 158, 158),
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: B,
            title: const Text(
              "Create PlayList ",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            content: TextFormField(
              controller: Playlist_control,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5, color: B))),
            ),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    final play_ = Playlist_control.text.trim();
                    final music = Music_Model(name: play_, songid: []);

                    // ignore: unused_local_variable
                    final datas = PlaylistDb.playlistDb.values
                        .map((e) => e.name.trim())
                        .toList();
                    if (play_.isEmpty) {
                      return;
                    } else if (datas.contains(music.name)) {
                      Get.snackbar("Warning",
                          "This PlayList Already Exist Create a new PLayList",
                          colorText: Colors.white, backgroundColor: B);
                    } else {
                      final alredyadd = Music_Model(name: play_, songid: []);
                      PlaylistDb.addPlaylist(alredyadd);
                      Get.back();
                      Get.snackbar("PlaList", "New PlayList Created",
                          colorText: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          backgroundGradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [S, B]));
                    }
                  },
                  icon: const Icon(Icons.playlist_add),
                  label: const Text("Add")),
              TextButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Color.fromARGB(255, 255, 17, 0),
                  ),
                  label: const Text("Cancel")),
            ],
          );
        }));
  }
}
