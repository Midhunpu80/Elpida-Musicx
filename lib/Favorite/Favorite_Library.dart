// ignore_for_file: unused_import, file_names, prefer_const_constructors, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Favorite/Favorate.dart';
import 'package:music_player/HomePage/HomePage1.dart';
import 'package:music_player/Model/FavoriteModel/Favorite_Model.dart';
import 'package:music_player/Music_PLaying_Screen/Now_play.dart';
import 'package:music_player/controllers/control.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

////////listview builder/////////////////////

// ignore: non_constant_identifier_names
Favorite_Library(double Fheight, double fwidth2) {
  return Container(
    margin: const EdgeInsets.only(left: 15, right: 15),
    height: Fheight,
    width: fwidth2,
    child: ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteSongs,
        builder: (context, favoratedata, child) {
          return favoratedata.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                        height: 40.h,
                        width: 100.w,
                        child: Lottie.network(
                            "https://assets9.lottiefiles.com/packages/lf20_KOXhzYGQfb.json")),
                    Text(
                      "Add favorites ",
                      style: TextStyle(color: S, fontSize: 18.sp),
                    ),
                  ],
                )
              : ListView.separated(
                  itemBuilder: (context, index) => Card(
                        color: Colors.black,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  image: AssetImage("images/mus22.jpg"),
                                  fit: BoxFit.cover)),
                          child: ListTile(
                            onTap: (() {
                              List<SongModel> songlist = [...favoratedata];
                              GetAllSongController.audioPlayer.setAudioSource(
                                  GetAllSongController.createSongList(songlist),
                                  initialIndex: index);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      NowPlaying(songModel: songlist)));
                            }),
                            title: Text(
                              favoratedata[index].displayNameWOExt,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "${favoratedata[index].artist}",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: QueryArtworkWidget(
                              id: favoratedata[index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Container(
                                child: Lottie.network(
                                    "https://assets4.lottiefiles.com/private_files/lf30_fjln45y5.json"),
                              ),
                              artworkFit: BoxFit.cover,
                            ),
                            trailing: IconButton(
                                onPressed: () => {
                                      FavoriteDb.favoriteSongs
                                          .notifyListeners(),
                                      FavoriteDb.delete(favoratedata[index].id),
                                      Get.snackbar("Favourites",
                                          "Removed from The Favorites",
                                          colorText: Colors.white,
                                          backgroundColor: Colors.blueAccent,
                                          backgroundGradient: LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [Colors.red, B]))
                                    },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: favoratedata.length);
        }),
  );
}
