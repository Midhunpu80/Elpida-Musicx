// ignore_for_file: file_names, camel_case_types, duplicate_ignore, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Model/FavoriteModel/Favorite_Model.dart';
import 'package:music_player/Model/dbfunction/Recently_PlayedDb.dart';
import 'package:music_player/Music_PLaying_Screen/Now_play.dart';
import 'package:music_player/bottomsheet/bottom_Sheet.dart';
import 'package:music_player/controllers/control.dart';
import 'package:music_player/newPLayList/smallPlayList/smallPlaylist.dart';

import 'package:on_audio_query/on_audio_query.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class recently_Libary extends StatefulWidget {
  @override
  State<recently_Libary> createState() => _recently_LibaryState();
}

class _recently_LibaryState extends State<recently_Libary> {
  List<SongModel> recent = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future initialize() async {
    await GetRecentlyPlayed.getRecentlySongs();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaquery = MediaQuery.of(context).size;
    return FutureBuilder(
        future: GetRecentlyPlayed.getRecentlySongs(),
        builder: (context, item) {
          return ValueListenableBuilder(
              valueListenable: GetRecentlyPlayed.recentSongNotifier,
              builder: (context, value, child) {
                if (value.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 130, left: 30),
                    child: Column(
                      children: [
                        Container(
                          child: Lottie.network(
                              "https://assets9.lottiefiles.com/packages/lf20_KOXhzYGQfb.json"),
                        ),
                        const Text(
                          "Your Recent Is Empty",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(147, 255, 255, 255)),
                        ),
                      ],
                    ),
                  );
                } else {
                  final temp = value.toList();
                  recent = temp.toSet().toList();

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
                              image: DecorationImage(
                                  image: AssetImage("images/mus22.jpg"),
                                  fit: BoxFit.cover)),
                          child: ListView.separated(
                              itemBuilder: ((context, index) {
                                return Container(
                                  child: ListTile(
                                    onTap: () {
                                      GetAllSongController.audioPlayer
                                          .setAudioSource(
                                        GetAllSongController.createSongList(
                                            recent),
                                        initialIndex: index,
                                      );
                                      Get.to(() => NowPlaying(
                                            songModel: recent,
                                            count: recent.length,
                                          ));
                                    },
                                    leading: Text(
                                      "${index + 1}",
                                      style: TextStyle(color: Colors.white),
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
                                                                  Get.snackbar(
                                                                      "Favorites",
                                                                      "Removed From The  Favorites",
                                                                      colorText:
                                                                          Colors
                                                                              .white,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blueAccent,
                                                                      backgroundGradient: LinearGradient(
                                                                          begin:
                                                                              Alignment.centerRight,
                                                                          end: Alignment.centerLeft,
                                                                          colors: [
                                                                            Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                17,
                                                                                0),
                                                                            B
                                                                          ]));

                                                                  ////////////////////////////////////add the favorite ////////////////////////////////////////////////////
                                                                } else {
                                                                  FavoriteDb.add(
                                                                      item.data![
                                                                          index]);
                                                                  // ignore: unused_local_variable
                                                                  Get.snackbar(
                                                                      "Favorites",
                                                                      "Added The Favorites",
                                                                      colorText:
                                                                          Colors
                                                                              .white,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blueAccent,
                                                                      backgroundGradient: LinearGradient(
                                                                          begin:
                                                                              Alignment.centerRight,
                                                                          end: Alignment.centerLeft,
                                                                          colors: [
                                                                            S,
                                                                            B
                                                                          ]));
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
                                            }));
                                      },
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                      recent[index].displayNameWOExt,
                                      overflow: TextOverflow.visible,
                                      maxLines: 1,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text("${recent[index].artist}",
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                );
                              }),
                              separatorBuilder: ((context, index) {
                                return const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                );
                              }),
                              itemCount: recent.length),
                        );
                      });
                }
              });
        });
  }
}
