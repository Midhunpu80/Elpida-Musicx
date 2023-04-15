import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/NewDb/Music_Model.dart';

class PlaylistDb extends ChangeNotifier {
  static ValueNotifier<List<Music_Model>> playlistNotifier = ValueNotifier([]);
  static final playlistDb = Hive.box<Music_Model>('playlistDb');

  static Future<void> addPlaylist(Music_Model value) async {
    final playlistDb = await Hive.openBox<Music_Model>('playlistDb');

    playlistDb.add(value);
    playlistNotifier.value.add(value);
    playlistNotifier.notifyListeners();
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = await Hive.openBox<Music_Model>('playlistDb');
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistDb.values);
    playlistNotifier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = await Hive.openBox<Music_Model>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> editPlaylist(int index, Music_Model value) async {
    final playlistDb = await Hive.openBox<Music_Model>('playlistDb');
    await playlistDb.putAt(index, value);
    getAllPlaylist();
  }
}
