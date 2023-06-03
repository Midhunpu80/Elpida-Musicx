// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Model/FavoriteModel/Favorite_Model.dart';

import 'package:music_player/Model/Mostly_played_Db/MostlyDb.dart';
import 'package:music_player/Music_PLaying_Screen/Now_play.dart';
import 'package:music_player/bottomsheet/bottom_Sheet.dart';
import 'package:music_player/controllers/control.dart';
import 'package:music_player/newPLayList/smallPlayList/smallPlaylist.dart';

import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Mostly_Libary extends StatelessWidget {
  List<SongModel> Mostly = [];

  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future initialize() async {
    await GetMostlyPlayedController.getMostlyplayed();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaquery = MediaQuery.of(context).size;
    return FutureBuilder(
        future: GetMostlyPlayedController.getMostlyplayed(),
        builder: (context, item) {
          return ValueListenableBuilder(
              valueListenable: GetMostlyPlayedController.mostlyPlayedNotifier,
              builder: (context, value, child) {
                if (value.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 140, left: 30),
                    child: Column(
                      children: [
                        Container(
                          child: Lottie.network(
                              "https://assets9.lottiefiles.com/packages/lf20_KOXhzYGQfb.json"),
                        ),
                        const Text(
                          "Your Mostly  Is Empty",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(147, 255, 255, 255)),
                        ),
                      ],
                    ),
                  );
                } else {
                  final temp = value.reversed.toList();
                  Mostly = temp.toSet().toList();

                  return FutureBuilder<List<SongModel>>(
                      future: _audioQuery.querySongs(
                          sortType: null,
                          orderType: OrderType.ASC_OR_SMALLER,
                          uriType: UriType.EXTERNAL,
                          ignoreCase: true),
                      builder: (context, item) {
                        if (item.data == null) {
                          const CircularProgressIndicator();
                        } else if (item.data!.isEmpty) {
                          return const Center(
                            child: Text('No songs in your internal'),
                          );
                        }
                        return Container(
                          height: _mediaquery.height * 0.88,
                          width: _mediaquery.width,
                          decoration: const BoxDecoration(
                              // image: DecorationImage(
                              //     image: AssetImage("images/mus22.jpg"),
                              // fit: BoxFit.cover)
                              ),
                          child: ListView.separated(
                              itemBuilder: ((context, index) {
                                return Container(
                                  child: ListTile(
                                    onTap: () {
                                      GetAllSongController.audioPlayer
                                          .setAudioSource(
                                        GetAllSongController.createSongList(
                                            Mostly),
                                        initialIndex: index,
                                      );
                                      Get.to(NowPlaying(
                                        songModel: Mostly,
                                        count: Mostly.length,
                                      ));
                                    },
                                    leading: Text(
                                      "${index + 1}",
                                      style:
                                         TextStyle(color: A),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () => showModalBottomSheet(
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
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(4),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4))),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                    .isFavor(item
                                                                            .data![
                                                                        index])) {
                                                                  FavoriteDb
                                                                      .favoriteSongs
                                                                      .notifyListeners();
                                                                  FavoriteDb
                                                                      .delete(item
                                                                          .data![
                                                                              index]
                                                                          .id);
                                                                  snackbarnew(
                                                                      titlename:
                                                                          "favourite",
                                                                      grad: red,
                                                                      grad2: B,
                                                                      subname:
                                                                          "Removed from The favourite");

                                                                  ////////////////////////////////////add the favorite ////////////////////////////////////////////////////
                                                                } else {
                                                                  FavoriteDb.add(
                                                                      item.data![
                                                                          index]);
                                                                  snackbarnew(
                                                                      titlename:
                                                                          "favourite",
                                                                      grad: S,
                                                                      grad2: B,
                                                                      subname:
                                                                          "Added The Favorites");

                                                                  //         ]));
                                                                }
                                                                FavoriteDb
                                                                    .favoriteSongs
                                                                    // ignore: invalid_use_of_visible_for_testing_member
                                                                    .notifyListeners();
                                                                ////////////////////////////icons
                                                              },
                                                              icon: FavoriteDb.isFavor(
                                                                      item.data![
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
                                                                      .isFavor(item
                                                                              .data![
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
                                                                  item.data![
                                                                      index]),
                                                          icon: Icon(
                                                            Icons.playlist_add,
                                                            color: A,
                                                          ),
                                                          label: Text(
                                                              "ADD PlayList"))
                                                    ],
                                                  ));
                                            })),
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: A,
                                        )),
                                    title: Text(
                                      Mostly[index].displayNameWOExt,
                                      overflow: TextOverflow.visible,
                                      maxLines: 1,
                                      style:  TextStyle(
                                          fontSize: 13, color: A),
                                    ),
                                    subtitle: Text("${Mostly[index].artist}",
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 9, color:A)),
                                  ),
                                );
                              }),
                              separatorBuilder: ((context, index) {
                                return const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                );
                              }),
                              itemCount: Mostly.length),
                        );
                      });
                }
              });
        });
  }
}
