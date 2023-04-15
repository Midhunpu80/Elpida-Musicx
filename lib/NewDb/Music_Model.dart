// ignore_for_file: unused_element, iterable_contains_unrelated_type, camel_case_types, unused_import

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'Music_Model.g.dart';

@HiveType(typeId: 1)
class Music_Model extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songid;

  Music_Model({required this.name, required this.songid});

  add(int id) async {
    songid.add(id);
    save();
  }

  deleteData(int id) {
    songid.remove(id);
    save();
  }

  bool isValueIn(int id) {
    return songid.contains(id);
  }
}
