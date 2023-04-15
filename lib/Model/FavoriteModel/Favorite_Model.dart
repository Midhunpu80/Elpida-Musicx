// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, file_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteDb {
  static bool isInitialized = false;
  static final musicDb = Hive.box<int>('FavoriteDB');
  static ValueNotifier<List<SongModel>> favoriteSongs = ValueNotifier([]);
//////////////////////////INITIALIZE THE ALL SONGS /////////////////
  static initialize(List<SongModel> songslist) {
    for (SongModel song in songslist) {
      if (isFavor(song)) {
        favoriteSongs.value.add(song);
      }
    }
    isInitialized = true;
  }

///////////////////////check the value is exist in the list or not/////////////////////////////////////////////
  static isFavor(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
  
    }
    return false;
  }

//////////////////ADD THE SONG TO DATABASE /////////////////////
  static add(SongModel song) async {
    musicDb.add(song.id);
    favoriteSongs.value.add(song);
    FavoriteDb.favoriteSongs.notifyListeners();
  }

  static delete(int id) async {
    int deletekey = 0;
    if (!musicDb.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favorMap = musicDb.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
     musicDb.delete(deletekey);
    favoriteSongs.value.removeWhere((song) => song.id == id);
    
  }

  static clear() async {
    FavoriteDb.favoriteSongs.value.clear();
  }
}
