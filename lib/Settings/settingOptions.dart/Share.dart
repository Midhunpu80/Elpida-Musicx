// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

// ignore: use_key_in_widget_constructors
class Sharedscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Share",
            style: TextStyle(color: S),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: S,
              )),
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [Colors.transparent, A])),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    border: Border.all(color: Colors.white, width: 5)),
                height: 40.h,
                width: 90.w,
                child: Lottie.asset(
                  "images/mus35.json",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      Padding(
                          padding:const  EdgeInsets.only(left: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color:const  Color.fromARGB(255, 0, 255, 8),
                                borderRadius: BorderRadius.circular(100)),
                            height: 180,
                            width: 350,
                            child: Lottie.asset("images/mus24.json",
                                fit: BoxFit.cover),
                          )),
                      Positioned(
                        left: 63,
                        top: 41,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(60)),
                          child: IconButton(
                            onPressed: () {
                              Get.to(Share.share("https://play.google.com/store/apps/details?id=apps.brototype.music_player"));
                            },
                            icon: Icon(
                              Icons.share_rounded,
                              color: B,
                              size: 80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text("Share Elpida Musicx App",
                  style: TextStyle(
                      color: S, fontWeight: FontWeight.bold, fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
