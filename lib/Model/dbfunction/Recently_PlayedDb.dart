// ignore_for_file: non_constant_identifier_names, file_names, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/HomePage/HomePage1.dart';

import 'package:on_audio_query/on_audio_query.dart';

class GetRecentlyPlayed {
  static ValueNotifier<List<SongModel>> recentSongNotifier = ValueNotifier([]);
  static List recentlyplayed = [];



  //////tap that time  song  add in the recently played list //////////////////

  static Future<void> addRecentlyPlayed(Songid) async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    await recentDB.add(Songid);
    getRecentlySongs();
    recentSongNotifier.notifyListeners();
  }


//////managing mostly played songs /////////////////////////////////////
  static Future<void> getRecentlySongs() async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    // recentlyplayed = await recentDB.values.toList();
    displayRecentlySongs();
    recentSongNotifier.notifyListeners();
  }

  static Future<void> displayRecentlySongs() async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    final recentSongItems = recentDB.values.toList();
    recentSongNotifier.value.clear();
    recentlyplayed.clear();
    for (int i = 0; i < recentSongItems.length; i++) {
      for (int j = 0; j < startSong.length; j++) {
        if (recentSongItems[i] == startSong[j].id) {
          recentSongNotifier.value.add(startSong[j]);
          recentlyplayed.add(startSong[j]);
        }
      }
    }
  }
}