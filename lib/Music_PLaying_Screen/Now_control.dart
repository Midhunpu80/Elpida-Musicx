// ignore_for_file: prefer_const_declarations, prefer_const_constructors, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, file_names

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Model/FavoriteModel/Favorite_Model.dart';

import 'package:music_player/controllers/control.dart';
import 'package:music_player/newPLayList/smallPlayList/smallPlaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

class PlayingControls extends StatefulWidget {
  const PlayingControls({
    super.key,
    required this.count,
    required this.favSongModel,
    required this.lastSong,
    required this.firstSong,
  });

  final int count;
  final bool firstSong;
  final bool lastSong;
  final SongModel favSongModel;
  @override
  State<PlayingControls> createState() => _PlayingControlsState();
}

class _PlayingControlsState extends State<PlayingControls> {
  bool isPlaying = true;
  bool isShuffling = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: B,
                  border: Border.all(width: 1, color: S)),
              child: IconButton(
                  onPressed: () {
                    if (FavoriteDb.isFavor(widget.favSongModel)) {
                      FavoriteDb.delete(widget.favSongModel.id);
                      final remove = const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('SONG REMOVED FROM THE PLAYLIST '),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(remove);
                    } else {
                      FavoriteDb.add(widget.favSongModel);
                      final addFav = SnackBar(
                        backgroundColor: A,
                        content: Text('SONG ADDED THE FAVORITES'),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(addFav);
                    }
                    FavoriteDb.favoriteSongs.notifyListeners();
                  },
                  icon: FavoriteDb.isFavor(widget.favSongModel)
                      ? Icon(
                          Icons.favorite,
                          color: A,
                        )
                      : Icon(
                          Icons.favorite_border_outlined,
                          color: S,
                        )),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: B,
                  border: Border.all(width: 1, color: S)),
              child: IconButton(
                  onPressed: () {
                    playlistDialogue(context, widget.favSongModel);
                  },
                  icon: Icon(
                    Icons.playlist_add,
                    size: 30,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: B,
                  border: Border.all(width: 1, color: S)),
              child: IconButton(
                onPressed: () {
                  isShuffling == false
                      ? GetAllSongController.audioPlayer
                          .setShuffleModeEnabled(true)
                      : GetAllSongController.audioPlayer
                          .setShuffleModeEnabled(false);
                },
                icon: StreamBuilder<bool>(
                  stream:
                      GetAllSongController.audioPlayer.shuffleModeEnabledStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      isShuffling = snapshot.data;
                    }
                    if (isShuffling) {
                      return Icon(
                        Icons.shuffle,
                        size: 30,
                        color: Colors.white,
                      );
                    } else {
                      return Icon(
                        Icons.shuffle,
                        color: S,
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: B,
                  border: Border.all(width: 1, color: S)),
              child: IconButton(
                onPressed: () {
                  GetAllSongController.audioPlayer.loopMode == LoopMode.one
                      ? GetAllSongController.audioPlayer
                          .setLoopMode(LoopMode.all)
                      : GetAllSongController.audioPlayer
                          .setLoopMode(LoopMode.one);
                },
                icon: StreamBuilder<LoopMode>(
                  stream: GetAllSongController.audioPlayer.loopModeStream,
                  builder: (context, snapshot) {
                    final loopMode = snapshot.data;
                    if (LoopMode.one == loopMode) {
                      return Icon(
                        Icons.repeat,
                        size: 30,
                        color: S,
                      );
                    } else {
                      return Icon(
                        Icons.repeat,
                        color: A,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
// skip previous
            widget.firstSong
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: B,
                        border: Border.all(width: 1, color: S)),
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.skip_previous,
                        color: Colors.transparent,
                        size: 35.sp,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: B,
                        border: Border.all(width: 1, color: S)),
                    child: IconButton(
                      onPressed: () {
                        if (GetAllSongController.audioPlayer.hasPrevious) {
                          GetAllSongController.audioPlayer.seekToPrevious();
                        }
                      },
                      icon: Icon(
                        Icons.skip_previous,
                        color: A,
                        size: 35.sp,
                      ),
                    ),
                  ),
// play pause

            Container(
              decoration: BoxDecoration(
                  color: B,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: S, width: 1)),
              child: IconButton(
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        if (GetAllSongController.audioPlayer.playing) {
                          GetAllSongController.audioPlayer.pause();
                        } else {
                          GetAllSongController.audioPlayer.play();
                        }
                        isPlaying = !isPlaying;
                      });
                    }
                  },
                  icon: isPlaying
                      ? Icon(
                          Icons.pause,
                          color: A,
                          size: 50.sp,
                        )
                      : Icon(
                          Icons.play_arrow,
                          color: A,
                          size: 50.sp,
                        )),
            ),

// skip next
            widget.lastSong
                ? Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: B,
                          border: Border.all(width: 1, color: S)),
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.transparent,
                          size: 35.sp,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: B,
                          border: Border.all(width: 1, color: S)),
                      child: IconButton(
                        onPressed: () {
                          if (GetAllSongController.audioPlayer.hasNext) {
                            GetAllSongController.audioPlayer.seekToNext();
                          }
                        },
                        icon: Icon(
                          Icons.skip_next,
                          color: A,
                          size: 35.sp,
                        ),
                      ),
                    ),
                  )
          ],
        )
      ],
    );
  }
}
