// ignore_for_file: file_names, must_be_immutable, camel_case_types, duplicate_ignore, non_constant_identifier_names, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Model/PlayList_Db/PLayList_Db.dart';

import 'package:music_player/NewDb/Music_Model.dart';
import 'package:music_player/controllers/control.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistAddSong extends StatefulWidget {
  PlaylistAddSong({super.key, required this.playlist});
  Music_Model playlist;
  @override
  State<PlaylistAddSong> createState() => _PlaylistAddSongState();
}

class _PlaylistAddSongState extends State<PlaylistAddSong> {
  bool isPlaying = true;
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_new_sharp, color: S)),
          backgroundColor: Colors.transparent,
          title: Text(
            "Add songs",
            style: TextStyle(color: S),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: Text('No songs availble'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: ListTile(
                    leading: QueryArtworkWidget(
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        artworkWidth: 50,
                        artworkHeight: 50,
                        keepOldArtwork: true,
                        artworkBorder: BorderRadius.circular(6),
                        nullArtworkWidget: Lottie.asset("images/mus23.json")),
                    title: Text(
                      item.data![index].displayNameWOExt,
                      maxLines: 1,
                      style: TextStyle(color: S),
                    ),
                    subtitle: Text(
                      item.data![index].artist.toString(),
                      style: TextStyle(color: S),
                      maxLines: 1,
                    ),
                    trailing: SizedBox(
                      height: 60,
                      width: 60,
                      child: Container(
                        child: !widget.playlist.isValueIn(item.data![index].id)
                            ? IconButton(
                                onPressed: () {
                                  PlaylistDb.playlistNotifier.notifyListeners();
                                  setState(() {
                                    GetAllSongController.songscopy = item.data!;
                                    // ignore: invalid_use_of_protected_member

                                    songAddToPlaylist(item.data![index]);
                                  });

                                  PlaylistDb.playlistNotifier.notifyListeners();
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: S)),
                                  child: Icon(
                                    Icons.add,
                                    color: A.withOpacity(0.5),
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  PlaylistDb.playlistNotifier.notifyListeners();
                                  setState(() {
                                    songDeleteFromPlaylist(item.data![index]);
                                  });
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: const Color.fromARGB(255, 255, 0, 0)
                                      .withOpacity(0.5),
                                ),
                              ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: item.data!.length,
            );
          },
        ),
      ),
    );
  }

  songAddToPlaylist(SongModel data) async {
    await widget.playlist.add(data.id);
    Get.snackbar("Song", "Song Added The PLaylist",
        colorText: Colors.white,
        backgroundColor: Colors.blueAccent,
        backgroundGradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              S,
              B,
            ]));
  }

  songDeleteFromPlaylist(SongModel data) async {
    const Duration(microseconds: 1);
    await widget.playlist.deleteData(data.id);
    Get.snackbar("Song", "Song Removed",
        colorText: Colors.white,
        backgroundColor: Colors.blueAccent,
        backgroundGradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [B, const Color.fromARGB(255, 255, 0, 0)]));
  }
}
