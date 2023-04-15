// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, duplicate_ignore, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/HomePage/ALL_Songs_List.dart';
import 'package:music_player/Serch.dart/serchReafactor/Serch_Library.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';

class serch_Page1 extends StatefulWidget {
  @override
  State<serch_Page1> createState() => _serch_Page1State();
}

class _serch_Page1State extends State<serch_Page1> {
  @override
  void initState() {
    songsLoading();
    super.initState();
  }

  // ignore: no_leading_underscores_for_local_identifiers
  Widget _icon_buttom(var _icon) {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          _icon,
          color: A,
        ));
  }

  List<SongModel> allsongs = [];
  List<SongModel> foundSongs = [];
  final audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    var _mediaquery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        drawer: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 5, color: A),
              borderRadius: BorderRadius.circular(10)),
          child: Drawer(
            // ignore: sort_child_properties_last
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(200.h)),
                  height: 20.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Image.asset(
                        "images/mus21.jpg",
                        fit: BoxFit.cover,
                      ),
                      allTXT,
                      allTXT1
                    ],
                  ),
                )
              ],
            ),
            width: 10.h,
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Container(
          height: _mediaquery.height,
          width: _mediaquery.width,
          color: Colors.transparent,
          child: ListView(
            children: [
              Serch_appbar(
                sheight1: _mediaquery.height * 0.1,
                scolor1: Colors.transparent,
                swidth1: _mediaquery.width,
              ),

              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Welcome",
                  style: TextStyle(color: S, fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 5),
                child: Text(
                  "Enjoy Your Favoraite Music",
                  style: TextStyle(
                      color: S, fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              /////////////////////////////serchbar//////////////////////////////////////////
              Container(
                  height: 45,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                      onChanged: (value) {
                        updateList(value);

                        ///when the user type filter the data ////////////////////////////////////////////////
                      },
                      decoration: InputDecoration(
                          suffixIcon: _icon_buttom(Icons.search_rounded),
                          prefixIcon: _icon_buttom(Icons.music_note_outlined),
                          hintText: "Search something.....",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid, width: 5, color: S),
                              borderRadius: BorderRadius.circular(50))))
                  //  ))),
                  ),
              const SizedBox(
                height: 20,
              ),

              //////////////////////////suggestions/////////////////////////////////
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "suggestions",
                  style: TextStyle(color: S, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Home_Music_Library(
                height3: _mediaquery.height * 0.7,
                height45: _mediaquery.height * 0.11,
                width45: _mediaquery.width * 0.12,
                color3: Colors.transparent,
                width4: _mediaquery.width,
                songModel: foundSongs.reversed.toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void songsLoading() async {
    allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    setState(() {
      foundSongs = allsongs;
    });
  }

  void updateList(String enteredText) {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .trim()
              .contains(enteredText.toLowerCase().trim()))
          .toList();
    }
    setState(() {
      foundSongs = results;
    });
  }
}
