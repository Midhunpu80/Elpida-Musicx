// ignore_for_file: no_leading_underscores_for_local_identifiers, camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/AllColors/allColors.dart';
import 'package:music_player/Settings/settingOptions.dart/setting_Reafactor.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class privacy_Policy extends StatelessWidget {
  // ignore: prefer_final_fields
  var _sbox = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    var _mediqaquey = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Privacy/Policy",
          style: TextStyle(
            color: S,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: S,
            )),
      ),
      body: Container(
        height: _mediqaquey.height,
        width: _mediqaquey.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [Colors.transparent, A])),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              text_privacy_policy2("Privacy Policy for Elpida Musixcs App", 15),
              _sbox,
              text_privacy_policy(
                  "At Elpida Musics, we respect your privacy and are committed to protecting your personal data. This Privacy Policy describes how we collect, use, and disclose your information when you use our music app."),
              _sbox,
              text_privacy_policy2(
                  "Information we collect \n the following information when you use our music app",
                  15),
              _sbox,
              text_privacy_policy(
                  "1.  Personal information: This includes your name, email address, and phone number."),
              text_privacy_policy(
                  "2.  Usage information: This includes information about how you use our music app, such as the types of music you listen to, the playlists you create, and your interactions with other users."),
              text_privacy_policy(
                  "3.   Usage information: This includes information about how you use our music app, such as the types of music you listen to, the playlists you create, and your interactions with other users."),
              _sbox,
              text_privacy_policy2(
                  "How we use your informationWe use your information for the following purposes:",
                  15),
              _sbox,
              text_privacy_policy(
                  "1.  o provide you with our music app services: We use your personal and usage information to provide you with the music app services that you have requested.\n  2.  To improve our music app: We use your usage and device information to improve our music app, such as by identifying and fixing bugs, optimizing our app for different devices, and enhancing our user experience.\n3.   To communicate with you: We use your personal information to communicate with you about our music app, such as to notify you of updates or changes to our app or to respond to your customer service inquiries."),
              _sbox,
              text_privacy_policy2("How we share your information", 15),
              _sbox,
              text_privacy_policy(
                  "We do not sell, rent, or share your personal information with third parties for marketing purposes. However, we may share your information with third-party service providers who help us provide our music app services, such as hosting providers, payment processors, and customer support services."),
              text_privacy_policy(
                  "We may also share your information with law enforcement or other government authorities if required by law or to protect our rights and interests."),
              _sbox,
              text_privacy_policy2("Security", 15),
              text_privacy_policy(
                  "We take reasonable measures to protect your information from unauthorized access, disclosure, or alteration. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security"),
              _sbox,
              text_privacy_policy2("Changes to this Privacy Policy", 15),
              _sbox,
              text_privacy_policy(
                  "We may update this Privacy Policy from time to time by posting a new version on our website. We encourage you to check this page regularly to stay informed about our information practices."),
              _sbox,
              text_privacy_policy2("Contact us", 14),
              _sbox,
              text_privacy_policy(
                  "If you have any questions about this Privacy Policy or our information practices,\n please contact us at midhunpu@gmail.com."),
              _sbox,
              text_privacy_policy2("Last updated: March 03 ,2023", 14),
              _sbox,
              text_privacy_policy2("Thanks for Reading ", 12),
            ],
          ),
        ),
      ),
    );
  }
}
