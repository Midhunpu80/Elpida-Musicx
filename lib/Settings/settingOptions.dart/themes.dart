// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/main.dart';

// ignore: use_key_in_widget_constructors
class The_mes extends StatefulWidget {
  @override
  State<The_mes> createState() => _The_mesState();
}

class _The_mesState extends State<The_mes> {
  @override
  Widget build(BuildContext context) {
    var _mediqaquey = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: S,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Themes",
          style: TextStyle(color: S, fontSize: 20),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box(newtheme).listenable(),
          // ignore: avoid_types_as_parameter_names
          builder: (context, Box, child) {
            final isdark = Box.get("isdark", defaultValue: false);

            return Container(
              height: _mediqaquey.height,
              width: _mediqaquey.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [Colors.transparent, A])),
              child: ListView(
                children: [
                  Switch(
                    onChanged: (value) {
                      Box.put("isdark", value);
                      isdark
                          ? snackbarnew(
                            titlename: "Theme",
                              grad: B,
                              grad2: Colors.amber,
                              subname: "Theme Changed   Light Mode ")
                          : snackbarnew(
                              titlename: "Theme",
                              grad: Colors.white,
                              grad2: B,
                              subname: "Theme Changed  Dark Mode ");
                    },
                    value: isdark,
                  ),
                  // Container(
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(50)),
                  //     height: 500,
                  //     width: 200,
                  //     child: isdark
                  //         ? Lottie.asset("images/mus25.json")
                  //         : Lottie.asset("images/mus34.json")),
                  Align(
                      alignment: Alignment.topCenter,
                      child: isdark
                          ? const Text(
                              "Dark",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )
                          : const Text(
                              "Light",
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 25),
                            ))
                ],
              ),
            );
          }),
    );
  }
}
