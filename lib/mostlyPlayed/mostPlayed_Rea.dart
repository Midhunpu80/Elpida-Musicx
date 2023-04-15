// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:music_player/Model/Mostly_played_Db/MostlyDb.dart';
import 'package:music_player/Music_PLaying_Screen/Now_play.dart';
import 'package:music_player/bottomsheet/bottom_Sheet.dart';
import 'package:music_player/controllers/control.dart';

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
                                          const TextStyle(color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () => show_modelsheet(
                                            contetx: context,
                                            sheet_Height: 300,
                                            sheet_Width: double.infinity,
                                            sheet_color: Colors.blue),
                                        icon: const Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.white,
                                        )),
                                    title: Text(
                                      Mostly[index].displayNameWOExt,
                                      overflow: TextOverflow.visible,
                                      maxLines: 1,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text("${Mostly[index].artist}",
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
                              itemCount: Mostly.length),
                        );
                      });
                }
              });
        });
  }
}
