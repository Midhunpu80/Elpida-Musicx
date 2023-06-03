// ignore_for_file: camel_case_types, must_be_immutable, empty_constructor_bodies, invalid_use_of_protected_member, non_constant_identifier_names, unused_local_variable, invalid_use_of_visible_for_testing_member, unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_final_fields, file_names, duplicate_ignore, avoid_print, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';

import 'package:music_player/Model/FavoriteModel/Favorite_Model.dart';
import 'package:music_player/Model/Mostly_played_Db/MostlyDb.dart';
import 'package:music_player/Model/dbfunction/Recently_PlayedDb.dart';
import 'package:music_player/Music_PLaying_Screen/Now_play.dart';

import 'package:music_player/controllers/control.dart';
import 'package:music_player/newPLayList/smallPlayList/smallPlaylist.dart';

import 'package:on_audio_query/on_audio_query.dart';

////////HOME MUSIC LIBRARY/////////////////////////////////
class Home_Music_Library extends StatefulWidget {
  List<SongModel> songModel;

  double? height3;

  double? width4;
  Color? color3;
  double? width45;

  double? height45;

  final dynamic recentlength;
  dynamic isRecent;

  Home_Music_Library(
      {super.key,
      required this.height3,
      required this.height45,
      required this.width45,
      required this.color3,
      required this.width4,
      required this.songModel,
      this.recentlength,
      this.isRecent}) {}

  @override
  State<Home_Music_Library> createState() => _Home_Music_LibraryState();
}

class _Home_Music_LibraryState extends State<Home_Music_Library> {
//////////////////////////////////////////////////////

//////////////////////for the music controlller /////////////////

  play_song(String? uri) async {
    try {
      await GetAllSongController.audioPlayer.setAudioSource(AudioSource.uri(
          Uri.parse(
              uri!))); //setAudioSource(AudioSource.uri((Uri.parse(uri!))));
      await GetAllSongController.audioPlayer.play();
    } on Exception {
      log("error parse");
    }
  }

  var _controller = ScrollController();

  // ignore: unused_field
  static OnAudioQuery audioquery = OnAudioQuery();

  List<SongModel> allsongs = [];

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    play_song("");
  }

  @override
  Widget build(BuildContext context) {
    allsongs.addAll(widget.songModel);
    return Container(
        height: 500,
        color: Colors.transparent,
        width: double.infinity,
        child: Container(
            color: Colors.transparent,
            child: Container(
                margin: const EdgeInsets.all(11),
                height: widget.height3,
                width: widget.width4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // image:  DecorationImage(gre
                  //     image: AssetImage("images/mus15.jpg"), fit: BoxFit.cover),
                ),
                child: ListView.separated(
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color.fromARGB(27, 158, 158, 158),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(131, 0, 213, 255))),
                            child: ListTile(
                         
                              hoverColor: red,
                              //  selectedTileColor: Color.fromARGB(255, 42, 226, 220),
                                selected: true,
                              
                                ////////////
                                //////////////////////control  the music/////////////////////////
                                onTap: () {
                                  GetMostlyPlayedController.addMostlyPlayed(
                                      widget.songModel[index].id);
                                  GetRecentlyPlayed.addRecentlyPlayed(
                                      widget.songModel[index].id);
                                  // Mostlyplayedctl.addmostlyplayed(
                                  //     widget.songModel[index].id);
                                  GetAllSongController.audioPlayer
                                      .setAudioSource(
                                    GetAllSongController.createSongList(
                                        widget.songModel),
                                    initialIndex: index,
                                  );

                                  // play_song(item.data![index].uri);
                                  Get.to(() => NowPlaying(
                                        songModel: widget.songModel,
                                        count: widget.songModel.length,
                                      ));

                                  ///n  _player.stop();
                                },
                                ///////////////////////////////////////////////////////////////////////////er://///////////////////////////////
                                title: Text(
                                  widget.songModel[index].displayNameWOExt,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  "${widget.songModel[index].artist.toString()}",
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 12),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(1)),
                                          context: context,
                                          builder: ((context) {
                                            return Container(
                                                height: 100,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4),
                                                            topRight:
                                                                Radius.circular(
                                                                    4))),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    /////////////////////////////////////addd favorites in music app ////////////////////////////////////////////////////////////////
                                                    ValueListenableBuilder(
                                                        valueListenable:
                                                            FavoriteDb
                                                                .favoriteSongs,
                                                        builder: (context,
                                                            List<SongModel>
                                                                favoriteSongs,
                                                            child) {
                                                          return TextButton
                                                              .icon(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              //////////////////////////delete/////////////////////////////////
                                                              if (FavoriteDb
                                                                  .isFavor(widget
                                                                          .songModel[
                                                                      index])) {
                                                                FavoriteDb
                                                                    .favoriteSongs
                                                                    .notifyListeners();
                                                                FavoriteDb.delete(
                                                                    widget
                                                                        .songModel[
                                                                            index]
                                                                        .id);
                                                                snackbarnew(
                                                                    titlename:
                                                                        "Favorites",
                                                                    grad: red,
                                                                    grad2: B,
                                                                    subname:
                                                                        "Removed From The  Favorites");

                                                                ////////////////////////////////////add the favorite ////////////////////////////////////////////////////
                                                              } else {
                                                                FavoriteDb.add(
                                                                    widget.songModel[
                                                                        index]);
                                                                // ignore: unused_local_variable
                                                                snackbarnew(
                                                                    titlename:
                                                                        "Favorites",
                                                                    grad: A,
                                                                    grad2: B,
                                                                    subname:
                                                                        "ADDED The  Favorites");
                                                              }
                                                              FavoriteDb
                                                                  .favoriteSongs
                                                                  // ignore: invalid_use_of_visible_for_testing_member
                                                                  .notifyListeners();
                                                              ////////////////////////////icons
                                                            },
                                                            icon: FavoriteDb.isFavor(
                                                                    widget.songModel[
                                                                        index])
                                                                ? Icon(
                                                                    Icons
                                                                        .favorite_border_outlined,
                                                                    color: S,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                  ),
                                                            label: FavoriteDb
                                                                    .isFavor(widget
                                                                            .songModel[
                                                                        index])
                                                                ? const Text(
                                                                    "REMOVE FAVORITE")
                                                                : const Text(
                                                                    "ADD FAVORITE"),
                                                          );
                                                        }),
                                                    TextButton.icon(
                                                        onPressed: () =>
                                                            playlistDialogue(
                                                                context,
                                                                widget.songModel[
                                                                    index]),
                                                        icon: Icon(
                                                          Icons.playlist_add,
                                                          color: A,
                                                        ),
                                                        label: Text(
                                                            "ADD PlayList"))
                                                  ],
                                                ));
                                          }));

                                      /////////////////////////////////////////////////////////////////////////////////////////////////
                                    },
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    )),
                                leading: nullwidegt(widget.songModel[index].id)

                                /////////////////////////////////////////////////////////lead////////////////

                                )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: widget.songModel.length))));
  }
}
