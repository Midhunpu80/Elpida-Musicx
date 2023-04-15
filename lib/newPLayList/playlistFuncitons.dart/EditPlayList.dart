// ignore_for_file: camel_case_types, non_constant_identifier_names, duplicate_ignore, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';

import 'package:music_player/Model/PlayList_Db/PLayList_Db.dart';
import 'package:music_player/NewDb/Music_Model.dart';

// ignore: unused_import
import 'package:sizer/sizer.dart';

Edit_Playlist(BuildContext context, index, dynamic name) {
  // ignore: non_constant_identifier_names
  TextEditingController Playlist_control = TextEditingController(text: name);
  showDialog(
      barrierColor: const Color.fromARGB(139, 158, 158, 158),
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: B,
          title: Text(
            "Add PlayList ",
            style: TextStyle(fontSize: 15, color: S),
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
                  if (play_.isEmpty) {
                    return;
                  } else {
                    final alredyadd = Music_Model(name: play_, songid: []);
                  PlaylistDb.editPlaylist(index, alredyadd);
                    Get.back();
  Get.snackbar("PlaList", "PlayList Updated",
                          colorText: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          backgroundGradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [Color.fromARGB(255, 0, 255, 8), B]));
                  }
                },
                icon: const Icon(Icons.playlist_add),
                label: const Text("Add")),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
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
