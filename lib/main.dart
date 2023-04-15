import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/AllColors/allColors.dart';

import 'package:music_player/NewDb/Music_Model.dart';

import 'package:music_player/Splash/Splash.dart';
import 'package:sizer/sizer.dart';

const newtheme = "themedata";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(MusicModelAdapter().typeId)) {
    Hive.registerAdapter(MusicModelAdapter());
  }
  // Hive.registerAdapter(MusicWorldAdapter());

  await Hive.initFlutter();

  await Hive.openBox<int>('FavoriteDB');
  await Hive.openBox('MostlyPlayedNotifier');
  await Hive.openBox('recentSongNotifier');
  await Hive.openBox<Music_Model>('playlistDb');
  await Hive.openBox(newtheme);

  // await Hive.openBox(fav);

  // Hive.registerAdapter("");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ValueListenableBuilder(
          valueListenable: Hive.box(newtheme).listenable(),
          // ignore: non_constant_identifier_names
          builder: (context, Box, child) {
            final isdark = Box.get("isdark", defaultValue: false);

            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: isdark
                  ? ThemeData(
                      primaryColor: B,
                      useMaterial3: true,
                      fontFamily: GoogleFonts.inder().fontFamily,
                    )
                  : ThemeData(
                      primarySwatch: Colors.amber,
                      primaryColor: Colors.white,
                      useMaterial3: true,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                    ),
              home: splash(),
            );
          });
    });
  }
}
