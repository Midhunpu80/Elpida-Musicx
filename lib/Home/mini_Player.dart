// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Model/dbfunction/Recently_PlayedDb.dart';
import 'package:music_player/controllers/control.dart';
import 'package:text_scroll/text_scroll.dart';

class mini_Player extends StatefulWidget {
  @override
  State<mini_Player> createState() => _mini_PlayerState();
}

bool firstSong = false;

bool isPlaying = false;

class _mini_PlayerState extends State<mini_Player> {
  // int currentIndex = 0;
  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null && mounted) {
          // int  currentIndex = index;
          setState(
            () {
              index == 0 ? firstSong = true : firstSong = false;
            },
          );
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
     
            borderRadius: BorderRadius.circular(25),
            color: Colors.black38,
            border: Border.all(color: A, width: 1)),
        child: Column(children: [
          Expanded(
            child: ListTile(
              title: StreamBuilder<bool>(
                  stream: GetAllSongController.audioPlayer.playingStream,
                  builder: (context, item) {
                    bool? playingStage = item.data;

                    if (playingStage != null && playingStage) {
                      return TextScroll(
                        GetAllSongController
                            .playingsong[
                                GetAllSongController.audioPlayer.currentIndex!]
                            .displayNameWOExt,
                        mode: TextScrollMode.endless,
                        style: TextStyle(
                            color: A,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      );
                    } else {
                      return TextScroll(
                        "",
                        mode: TextScrollMode.endless,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: A,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      );
                    }
                  }),
              leading: Lottie.asset("images/mus23.json"),
              trailing: FittedBox(
                fit: BoxFit.cover,
                child: Row(
                  children: [
                    firstSong
                        ? IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.skip_previous,
                              size: 50,
                              color: A,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              GetAllSongController.addRecentlyPlayed(
                                  GetAllSongController
                                      .playingsong[GetAllSongController
                                              .audioPlayer.currentIndex! -
                                          1]
                                      .id);
                              if (GetAllSongController
                                  .audioPlayer.hasPrevious) {
                                GetAllSongController.audioPlayer
                                    .seekToPrevious();
                                await GetAllSongController.audioPlayer.play();
                              } else {
                                await GetAllSongController.audioPlayer.play();
                              }
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              size: 50,
                              color: A,
                            )),
                    IconButton(
                      onPressed: () async {
                        if (GetAllSongController.audioPlayer.playing) {
                          await GetAllSongController.audioPlayer.pause();
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        } else {
                          await GetAllSongController.audioPlayer.play();
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        }
                      },
                      icon: StreamBuilder<bool>(
                          stream:
                              GetAllSongController.audioPlayer.playingStream,
                          builder: (context, snapshot) {
                            bool? playingStage = snapshot.data;
                            return playingStage != null && playingStage
                                ? Icon(
                                    Icons.pause_circle,
                                    size: 50,
                                    color: A,
                                  )
                                : Icon(
                                    Icons.play_circle_filled_outlined,
                                    color: A,
                                    size: 50,
                                  );
                          }),
                    ),
                    IconButton(
                      onPressed: () async {
                        GetRecentlyPlayed.addRecentlyPlayed(GetAllSongController
                            .playingsong[
                                GetAllSongController.audioPlayer.currentIndex! +
                                    1]
                            .id);
                        if (GetAllSongController.audioPlayer.hasNext) {
                          await GetAllSongController.audioPlayer.seekToNext();
                          await GetAllSongController.audioPlayer.play();
                        } else {
                          await GetAllSongController.audioPlayer.play();
                        }
                      },
                      icon: Icon(
                        Icons.skip_next,
                        size: 50,
                        color: A,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
