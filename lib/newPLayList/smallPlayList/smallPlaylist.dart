// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/Model/PlayList_Db/PLayList_Db.dart';

import 'package:music_player/NewDb/Music_Model.dart';
import 'package:music_player/newPLayList/Create_PLaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';

playlistDialogue(BuildContext context, SongModel songModel) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: const Text(
            'Select a Playlist',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          content: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<Music_Model>('playlistDb').listenable(),
                builder: (context, Box<Music_Model> musicList, child) {
                  return Hive.box<Music_Model>('playlistDb').isEmpty
                      ? const Center(
                          child: Text(
                          'No Playlist found',
                          style: TextStyle(fontSize: 18),
                        ))
                      : ListView.builder(
                          itemCount: musicList.length,
                          itemBuilder: (context, index) {
                            final data = musicList.values.toList()[index];
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(data.name),
                                trailing: const Icon(Icons.playlist_add,
                                    color: Colors.black),
                                onTap: () {
                                  addSongToPlaylist(
                                      context, songModel, data, data.name);
                                },
                              ),
                            );
                          });
                }),
          ),
          actions: [
            TextButton(
              onPressed: () {
                PlaylistDb.playlistNotifier.notifyListeners();

                /// Navigator.pop(context);
                Add_playList.alertBox(context);
              },
              child: const Text('New Playlist'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      });
}

void addSongToPlaylist(
    BuildContext context, SongModel data, datas, String name) {
  if (!datas.isValueIn(data.id)) {
    datas.add(data.id);
    final songAddSnackBar = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.fixed, //idhonn check akknm
        content: Text(
          "Song Added To $name",
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(songAddSnackBar);
    Navigator.pop(context);
  } else {
    final songAlreadyExist = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.fixed, //idhonn check akknm
        content: Text(
          "Song Already exist In $name",
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(songAlreadyExist);
    Navigator.pop(context);
  }
}
