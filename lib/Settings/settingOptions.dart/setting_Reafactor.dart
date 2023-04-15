// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:music_player/AllColors/allColors.dart';

// ignore: no_leading_underscores_for_local_identifiers
Widget text_privacy_policy(String _text) {
  return Text(
    _text,
    style: TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.black,
        fontSize: 12),
  );
}

// ignore: no_leading_underscores_for_local_identifiers
Widget text_privacy_policy2(String _text2, double _textsize) {
  return Text(
    _text2,
    style: TextStyle(
        color: Colors.black,
        fontSize: _textsize,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold),
  );
}

var s_box = SizedBox(
  height: 20,
);
