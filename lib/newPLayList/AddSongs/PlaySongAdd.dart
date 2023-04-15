// ignore_for_file: must_be_immutable, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';

import 'package:music_player/Model/PlayList_Db/PLayList_Db.dart';
import 'package:music_player/Model/dbfunction/Recently_PlayedDb.dart';
import 'package:music_player/Music_PLaying_Screen/Now_play.dart';
import 'package:music_player/NewDb/Music_Model.dart';

import 'package:music_player/controllers/control.dart';
import 'package:music_player/newPLayList/pickthesong/PicksongPlayList.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class PlaySongs_Add extends StatefulWidget {
  PlaySongs_Add({
    super.key,
    required this.playerdata1,
    required this.tindex,
  });

  final Music_Model playerdata1;

  int tindex;

  @override
  State<PlaySongs_Add> createState() => _PlaySongs_AddState();
}

class _PlaySongs_AddState extends State<PlaySongs_Add> {
  @override
  Widget build(BuildContext context) {
    List<SongModel> song_playlist;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.playerdata1.name,
            style: TextStyle(color: S),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: S,
            ),
          ),
        ),
        // ignore: avoid_unnecessary_containers
        body: ValueListenableBuilder(
            valueListenable: PlaylistDb.playlistNotifier,
            builder: (context, List<Music_Model> musiclisted, Widget? child) {
              song_playlist =
                  listPlaylist(musiclisted.toList()[widget.tindex].songid);

              return ListView(
                children: [
                  SizedBox(
                    // decoration: BoxDecoration(border: Border.all(width: 1,color: A)),
                    height: 40.h,
                    width: 100.h,
                    // color: B,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 65,
                          child: CircleAvatar(
                            radius: 100.sp,
                            backgroundColor: Colors.transparent,
                            child: Lottie.asset("images/mus24.json"),
                          ),
                        ),
                        Positioned(
                            top: 116,
                            left: 168,
                            child: IconButton(
                                onPressed: () {
                                  Get.to(()=>PlaylistAddSong(
                                      playlist: widget.playerdata1));
                                },
                                icon: Icon(
                                  Icons.playlist_add,
                                  color: B,
                                  size: 60,
                                ))),
                        Positioned(
                            top: 260,
                            left: 120,
                            child: TextButton.icon(
                              onPressed: () {},
                              label: Text(
                                "Add Songs",
                                style: TextStyle(color: S, fontSize: 20),
                              ),
                              icon: Icon(
                                Icons.add,
                                color: S,
                                size: 25,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: A,
                  ),
                  Container(
                      color: Colors.transparent,
                      height: 45.h,
                      width: 100.h,
                      child: song_playlist.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 230,
                                  child: Lottie.network(
                                      "https://assets9.lottiefiles.com/packages/lf20_KOXhzYGQfb.json"),
                                ),
                                Text(
                                  "No Songs",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: S),
                                ),
                              ],
                            )
                          : SizedBox(
                              child: ListView.separated(
                                  itemBuilder: ((context, index) {
                                    PlaylistDb.getAllPlaylist();
                                    // ignore: avoid_unnecessary_containers
                                    return Container(
                                      child: ListTile(
                                          onTap: () {
                                            GetAllSongController.audioPlayer
                                                .setAudioSource(
                                                    GetAllSongController
                                                        .createSongList(
                                                            song_playlist),
                                                    initialIndex: index);
                                            GetRecentlyPlayed.addRecentlyPlayed(
                                                song_playlist[index].id);

                                            Get.to(()=>
                                              NowPlaying(
                                                songModel: song_playlist,
                                                count: song_playlist.length,
                                              ),
                                            );
                                          },
                                          title: Text(
                                            song_playlist[index]
                                                .displayNameWOExt,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(color: S),
                                          ),
                                          subtitle: Text(
                                            song_playlist[index]
                                                .artist
                                                .toString(),
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                            style: TextStyle(color: S),
                                          ),
                                          leading: QueryArtworkWidget(
                                            keepOldArtwork: true,
                                            id: song_playlist[index].id,
                                            type: ArtworkType.AUDIO,
                                            nullArtworkWidget: Lottie.asset(
                                                "images/mus23.json"),
                                            artworkBorder:
                                                const BorderRadius.horizontal(),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  songDeleteFromPlaylist(
                                                      song_playlist[index],
                                                      context);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))),
                                    );
                                  }),
                                  separatorBuilder: ((context, index) {
                                    return const SizedBox(
                                      height: 0,
                                    );
                                  }),
                                  itemCount: song_playlist.length),
                            ))
                ],
              );
            }),
      ),
    );
  }

  void songDeleteFromPlaylist(SongModel data, context) {
    widget.playerdata1.deleteData(data.id);
    final removePlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: Text(
        'Song removed from Playlist',
        style: TextStyle(color: S),
      ),
      duration: const Duration(milliseconds: 550),
    );
    ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
  }

  List<SongModel> listPlaylist(List<dynamic> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetAllSongController.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongController.songscopy[i].id.toInt() == data[j]) {
          plsongs.add(GetAllSongController.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
