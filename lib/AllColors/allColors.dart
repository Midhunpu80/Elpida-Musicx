// ignore_for_file: prefer_const_declarations, prefer_const_constructors, use_full_hex_values_for_flutter_colors, duplicate_ignore, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

Color Ak = Color.fromARGB(255, 255, 0, 179);
Color A = Color.fromARGB(255, 11, 214, 255);
Color S = Color.fromARGB(255, 0, 225, 255);
Color red = Colors.red;
Color blccent = Colors.blueAccent;
Color wh = Colors.white;

Color B = Colors.black;
Color wk = Color.fromARGB(255, 20, 18, 50);
// Color S = Color.fromARGB(255, 255, 0, 179);

final allTXT = const Text(
  "ELPIDA MUSICX",
  style: TextStyle(color: Colors.white, fontSize: 15),
);

// ignore: prefer_const_constructors
final allTXT1 = Text(
  "1.0.03",
  // ignore: prefer_const_constructors
  style: TextStyle(color: Colors.white, fontSize: 15),
);

nullwidegt(int arr) {
  return QueryArtworkWidget(
    keepOldArtwork: true,
    artworkBorder: const BorderRadius.horizontal(
        right: Radius.circular(10), left: Radius.circular(10)),
    id: arr,
    type: ArtworkType.AUDIO,
    nullArtworkWidget: Container(
      height: 50,
      width: 50,
      decoration:
          BoxDecoration(color: S, borderRadius: BorderRadius.circular(10)),
      child: const Icon(
        Icons.music_note_sharp,
        color: Colors.white,
      ),
    ),
    artworkFit: BoxFit.cover,
  );
}

SnackbarController snackbarnew(
    {required String titlename,
    required Color grad,
    required Color grad2,
    required String subname}) {
  return Get.snackbar(titlename, subname,
      colorText: wh,
      backgroundColor: blccent,
      duration: Duration(milliseconds: 850),
      maxWidth: 150,
      borderWidth: 3,
      borderColor: Colors.amber,
      backgroundGradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [grad, grad2]));
}
