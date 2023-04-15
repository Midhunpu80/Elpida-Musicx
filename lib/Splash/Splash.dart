// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, camel_case_types, use_build_context_synchronously, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/Home/Home.dart';
import 'package:sizer/sizer.dart';

BoxDecoration bodyDecoration = const BoxDecoration(color: Colors.white);

const TextStyle title = TextStyle(
    color: Color.fromARGB(255, 253, 251, 251),
    fontWeight: FontWeight.bold,
    fontSize: 16);
const TextStyle artistStyle =
    TextStyle(color: Color.fromARGB(180, 252, 248, 248), fontSize: 14);

// ignore: use_key_in_widget_constructors
class splash extends StatefulWidget {
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    spla_sh();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var _mediquery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/mus22.jpg"), fit: BoxFit.fitHeight),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 320,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        )),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("images/mus21.jpg"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    child: AnimatedTextKit(animatedTexts: [
                  WavyAnimatedText("Elpida Musicx",
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5))
                ])),
                SizedBox(
                  height: 15.h,
                  width: 35.w,
                  child: Lottie.asset("images/mus29.json"),
                ),

                ///  AnimatedTextKit(animatedTexts: [WavyAnimatedText("elpid misics,",textStyle: TextStyle(color: Colors.white))])
              ],
            )),
      ),
    );
  }

  Future<void> spla_sh() async {
    // ignore: prefer_const_constructors
    await Future.delayed(Duration(seconds: 6));
    Get.to(Home());
  }
}
