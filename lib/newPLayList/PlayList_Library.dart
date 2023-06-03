// ignore_for_file: non_constant_identifier_names, camel_case_types, use_key_in_widget_constructors, empty_constructor_bodies, must_be_immutable, duplicate_ignore, prefer_const_constructors, file_names, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';

import 'package:music_player/Model/PlayList_Db/PLayList_Db.dart';
import 'package:music_player/NewDb/Music_Model.dart';

import 'package:music_player/newPLayList/AddSongs/PlaySongAdd.dart';

import 'package:music_player/newPLayList/playlistFuncitons.dart/EditPlayList.dart';
import 'package:sizer/sizer.dart';

////////////////////////////////////lsit of music ////////////////////////////
class playList_Libary extends StatefulWidget {
  double? Pheight3;
  double? Pwidth4;
  Color? Pcolor3;
  double? Pwidth45;
  List<Music_Model> Playlistpay;
  double? Pheight45;
  playList_Libary(
      {required this.Playlistpay,
      required this.Pheight3,
      required this.Pheight45,
      required this.Pwidth45,
      required this.Pcolor3,
      required this.Pwidth4}) {}

  @override
  State<playList_Libary> createState() => _playList_LibaryState();
}

class _playList_LibaryState extends State<playList_Libary> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    PlaylistDb.getAllPlaylist();
    return Container(
        height: 80.h,
        color: Colors.transparent,
        width: double.infinity,
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: Container(
            margin: EdgeInsets.all(5),
            height: widget.Pheight3,
            width: widget.Pwidth4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.Pcolor3,
            ),
            child: ValueListenableBuilder(
                valueListenable: PlaylistDb.playlistNotifier,
                builder:
                    (context, List<Music_Model> Playlistpay, Widget? child) {
                  return Playlistpay.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 250, left: 75),
                          child: Text(
                            "Create a new  PlayList",
                            style: TextStyle(fontSize: 20, color: S),
                          ),
                        )
                      : GridView.builder(
                          controller: _controller,
                          itemBuilder: (context, index) {
                            final data = widget.Playlistpay.toList()[index];

                            /// Playlistnotifier = data as List<Music_Model>;
                            return InkWell(
                              onTap: () {
                                Get.to(() => PlaySongs_Add(
                                      tindex: index,
                                      playerdata1: data,
                                    ));
                              },
                              child: Card(
                                color: Colors.transparent,
                                child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        // image: DecorationImage(image: AssetImage("images/mus5.jpg"),fit: BoxFit.cover ),

                                        border: Border.all(
                                          width: 1,
                                          color: S,
                                        )),
                                    child: Stack(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.folder,
                                              color: S,
                                              size: 35,
                                            )),
                                        Positioned(
                                            left: 60,
                                            child: IconButton(
                                                onPressed: () {
                                                  showBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          height: 100,
                                                          width:
                                                              double.infinity,
                                                          color: B,
                                                          child: Column(
                                                            children: [
                                                              TextButton.icon(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                    deletedialouge(
                                                                        context,
                                                                        index);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  label: Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                        color:
                                                                            S),
                                                                  )),
                                                              TextButton.icon(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();

                                                                    Edit_Playlist(
                                                                        context,
                                                                        index,
                                                                        data.name);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons.edit,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            255,
                                                                            30),
                                                                  ),
                                                                  label: Text(
                                                                    "Edit",
                                                                    style: TextStyle(
                                                                        color:
                                                                            S),
                                                                  ))
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                icon: Icon(
                                                  Icons.more_horiz,
                                                  color: S,
                                                ))),
                                        Positioned(
                                            top: 65,
                                            left: 10,
                                            child: Text(
                                              data.name,
                                              style: TextStyle(
                                                  color: S, fontSize: 15),
                                            ))
                                      ],
                                    )),
                              ),
                            );
                          },
                          itemCount: Playlistpay.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20));
                }),
          ),
        ));
  }

  void deletedialouge(BuildContext context, index) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: B,
            title: Text(
              "Warning",
              style: TextStyle(color: S),
            ),
            content: Text(
              "if you want to delete?",
              style: TextStyle(color: S),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    PlaylistDb.playlistNotifier.notifyListeners();
                    if (mounted) {
                      setState(() {
                        PlaylistDb.deletePlaylist(index);
                        Get.back();
                        snackbarnew(
                            titlename: "PlayList",
                            grad: red,
                            grad2: B,
                            subname: "Folder Removed From The  PlayList");
                      });
                    }
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "no",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        }));
  }
}
