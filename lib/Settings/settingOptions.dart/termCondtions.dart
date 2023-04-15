// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, camel_case_types, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Settings/settingOptions.dart/setting_Reafactor.dart';

class terms_conditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _mediqaquey = MediaQuery.of(context).size;
    return Scaffold(  backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title:  Text(
            "Terms&Conditions",
            style: TextStyle(color: S),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
        Get.back();
              },
              icon:  Icon(
                Icons.arrow_back_ios,
                color: S,
              )),
        ),
        body: Container(
            decoration:  BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                 Colors.transparent,A
                ])),
            height: _mediqaquey.height,
            width: _mediqaquey.width,

            ///  color: Color.fromARGB(255, 0, 0, 0),
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Container(
                child: ListView(children: [
                  text_privacy_policy2(
                      "Welcome to the music app! By using the  Elpida  musicx app, you agree to these terms and conditions. Please read them carefully.",
                      14),
                  s_box,
                  text_privacy_policy("1.Account Creation and Use:"),
                  s_box,
                  text_privacy_policy(
                      "a. In order to use the music app, you must create an account. You must be at least 13 years old to create an account.\nb. You are responsible for maintaining the confidentiality of your account login information and are fully responsible for all activities that occur under your account.\nc. You agree to immediately notify us of any unauthorized use, or suspected unauthorized use of your account or any other breach of security.c. You agree that all information you provide when creating an account is accurate, complete and up-to-date. You agree to update your information as necessary to maintain its accuracy."),
                  s_box,
                  text_privacy_policy2("2.User Conduct:", 15),
                  text_privacy_policy(
                      "a. You agree to use the music app only for lawful purposes and in a manner consistent with all applicable laws and regulations. You agree not to use the music app for any illegal, harmful or fraudulent activities.\nb. You agree not to use the music app to harass, intimidate, defame, or otherwise harm any other user of the music app.\nc. You agree not to post any content that is offensive, discriminatory, or violates the rights of any third party.\nd. You agree not to use any automated systems or software to access the music app or to scrape or download content from the music app.\ne. You agree not to interfere with the functioning of the music app or its servers, networks, or other infrastructure."),
                  s_box,
                  text_privacy_policy2("3.Intellectual Property:", 15),
                  text_privacy_policy(
                      "a. All content on the music app, including but not limited to music, images, and text, is protected by copyright and other intellectual property laws. You agree not to copy, distribute, or use any content from the music app without the prior written permission of the owner of the content.\nb. You agree not to upload or post any content to the music app that infringes on the intellectual property rights of any third party."),
                  s_box,
                  text_privacy_policy2("Disclaimer of Warranties:", 15),
                  text_privacy_policy(
                      "a. The music app is provided as isand without warranty of any kind. We make no warranty, express or implied, regarding the music app or its availability, accuracy, or reliability.\nb. We do not guarantee that the music app will be uninterrupted, error-free, or free of viruses or other harmful components.\nc. We are not responsible for any damages, direct or indirect, arising from your use of the music app."),
                  s_box,
                  text_privacy_policy2("4.Limitation of Liability:", 15),
                  text_privacy_policy(
                    "a. We will not be liable to you or any third party for any damages, direct or indirect, arising from your use of the music app.\nb. In no event will we be liable for any lost profits or other consequential, incidental, or punitive damages arising from your use of the music app.\nc. Our total liability to you for any and all claims arising from your use of the music app will not exceed the amount paid by you, if any, for access to the music app.",
                  ),
                  s_box,
                  text_privacy_policy2("5.Indemnification:", 15),
                  text_privacy_policy(
                      "You agree to indemnify and hold us harmless from any and all claims, damages, liabilities, and expenses, including reasonable attorneys' fees, arising from your use of the music app or your violation of these terms and conditions."),
                  s_box,
                  text_privacy_policy2("6.Indemnification:", 15),
                  text_privacy_policy(
                      "You agree to indemnify and hold us harmless from any and all claims, damages, liabilities, and expenses, including reasonable attorneys' fees, arising from your use of the music app or your violation of these terms and conditions."),
                  s_box,
                  text_privacy_policy2("7.Termination:", 15),
                  text_privacy_policy(
                      "We reserve the right to terminate your access to the music app at any time and for any reason, without notice or liability to you."),
                  s_box,
                  text_privacy_policy2("8.Changes to Terms and Conditions", 15),
                  text_privacy_policy(
                      "We reserve the right to modify these terms and conditions at any time. Your continued use of the music app following any such modifications will constitute your acceptance of the modified terms and conditions."),
                  s_box,
                  text_privacy_policy2("9.Governing Law: ", 15),
                  text_privacy_policy(
                      "These terms and conditions will be governed by and construed in accordance with the laws of [insert jurisdiction]. Any disputes arising under or in connection with these"),
                  text_privacy_policy2("Thanks for Reading ", 12),
                ]),
              ),
            )));
  }
}
