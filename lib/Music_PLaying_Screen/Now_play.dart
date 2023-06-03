// ignore: unused_import
// ignore_for_file: file_names, unused_import, duplicate_ignore, avoid_print

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Home/Home.dart';
import 'package:music_player/Home/mini_Player.dart';
import 'package:music_player/Music_PLaying_Screen/Now_control.dart';

import 'package:music_player/controllers/control.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({
    super.key,
    required this.songModel,
    this.count = 0,
  });
  final List<SongModel> songModel;
  final int count;
  // final AudioPlayer audioPlayer;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
////////////for next and previous ////////////////////////////
  int large = 0;
  int currentIndex = 0;
  bool firstSong = false;
  bool lastSong = false;
  // @override
  // void dispose() {
  //   super.dispose();
  //   playSong();
  // }

  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          GetAllSongController.currentIndexes = index;
          if (mounted) {
            setState(
              () {
                large = widget.count - 1;
                currentIndex = index;
                index == 0 ? firstSong = true : firstSong = false;
                index == large ? lastSong = true : lastSong = false;
              },
            );
          }
        }
      },
    );
    super.initState();
    playSong();
  }

/////////////////////////////////////////////////////////////
  ///
  ///
///////////////////for duration of music player //////////////////////////
  void playSong() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen(
      (d) {
        if (mounted) {
          setState(() {
            if (d != null) {
              _duration = d;
            }
          });
        }
      },
    );
    GetAllSongController.audioPlayer.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          _position = p;
        });
      }
    });
  }

//////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: B,
        appBar: AppBar(
          toolbarHeight: 11.h,
          backgroundColor: B,
          leading: IconButton(
            onPressed: () {
              Get.to(Home());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Now Playing',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => print("name"),
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ))
          ],
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient:  LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white,A]),
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                  
              // image: const DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage('images/mus22.jpg'),
              // ),
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(1),
                    blurRadius: 8),
              ],
            ),
            child: Column(
              children: [
                // QueryArtworkWidget(id: widget.songModel[currentIndex].id, type: ArtworkType.AUDIO),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30.h,
                  width: 61.w,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(0, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(200),
                          topLeft: Radius.circular(200),
                          topRight: Radius.circular(200))),
                  child: QueryArtworkWidget(
                    keepOldArtwork: true,
                    id: widget.songModel[currentIndex].id,
                    type: ArtworkType.AUDIO,
                    artworkBorder: const BorderRadius.only(
                        bottomLeft: Radius.circular(180),
                        bottomRight: Radius.circular(180),
                        topLeft: Radius.circular(180),
                        topRight: Radius.circular(180)),
                    nullArtworkWidget: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.pinkAccent,
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.black,
                          size: 95,
                        )),
                    artworkFit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        // title
                        child: TextScroll(
                          widget.songModel[currentIndex].displayNameWOExt,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          textAlign: TextAlign.center,
                          mode: TextScrollMode.endless,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        // artist name
                        //////////////////////////artist name ////////////////////////////
                        child: Text(
                          widget.songModel[currentIndex].artist.toString() ==
                                  '<unknown>'
                              ? "Unknown Artist"
                              : widget.songModel[currentIndex].artist
                                  .toString(),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                /////////////////////////////slider //////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: A,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 7,
                        elevation: 5,
                        pressedElevation: 5,
                      ),
                    ),
                    child: Slider(
                      activeColor: A,
                      inactiveColor: Colors.blueAccent,
                      value: _position.inSeconds.toDouble(),
                      max: _duration.inSeconds.toDouble(),
                      min: const Duration(microseconds: 0).inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(
                          () {
                            changeToSeconds(
                              value.toInt(),
                            );
                            value = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_position),
                        style: TextStyle(color: B),
                      ),
                      Text(
                        _formatDuration(_duration),
                        style: TextStyle(color: B),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: PlayingControls(
                      count: widget.count,
                      favSongModel: widget.songModel[currentIndex],
                      lastSong: lastSong,
                      firstSong: firstSong),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return "$minutes:$seconds";
    }
  }
}
