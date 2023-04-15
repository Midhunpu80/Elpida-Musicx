// ignore_for_file: non_constant_identifier_names, file_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:music_player/AllColors/allColors.dart';

show_modelsheet(
    {required BuildContext contetx,
    required double sheet_Height,
    required double sheet_Width,
    required Color sheet_color}) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
      context: contetx,
      builder: ((context) {
        return Container(
            height: sheet_Height,
            width: sheet_Width,
            decoration: BoxDecoration(
                color: sheet_color,
                image: const DecorationImage(
                    image: AssetImage("images/blur2.jpg"), fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: ListView(
              children: [
                TextButton.icon(
                    onPressed: () => print("name"),
                    icon: Icon(Icons.delete),
                    label: Text(
                      "Delete",
                      style: TextStyle(fontSize: 20, color: S),
                    ))
              ],
            ));
      }));
}
