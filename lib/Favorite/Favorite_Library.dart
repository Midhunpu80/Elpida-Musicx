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
                      "Add Favourite",
                      style: TextStyle(color: S, fontSize: 18.sp),
                    ),
                  ],
                )
              : ListView.separated(
                  itemBuilder: (context, index) => Card(
                        color: Color.fromARGB(27, 158, 158, 158),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(131, 0, 213, 255))),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            subtitle: Text(
                              "${favoratedata[index].artist}",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 9),
                            ),
                            leading: nullwidegt(favoratedata[index].id),
                            trailing: IconButton(
                                onPressed: () => {
                                      FavoriteDb.favoriteSongs
                                          .notifyListeners(),
                                      FavoriteDb.delete(favoratedata[index].id),
                                      snackbarnew(
                                          titlename: "favourite",
                                          grad: red,
                                          grad2: B,
                                          subname:
                                              "Removed from The favourite"),
                                    },
                                icon: Icon(
                                  Icons.favorite,
                                  color: S,
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
