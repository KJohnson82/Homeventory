import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Routes/Homes.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Theme/colorTheme.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      //Calls the theme from theme file to be used in th rest of the app
      theme: ThemeData.from(
          colorScheme: homeventory,
          useMaterial3: false,
          textTheme: GoogleFonts.poppinsTextTheme()),

      title: 'HOMVENTORY',
      home: Scaffold(
        // bottomNavigationBar: const BottomAppBar(
        //   elevation: 2,
        //   notchMargin: 10,
        //   shape: AutomaticNotchedShape(
        //     RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(30),
        //         )),
        //     StadiumBorder(),
        //   ),
        // ),
        appBar: AppBar(
          // Sets the phone icons to use dark mode
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
          backgroundColor: homeventory.primary,
          title: const Text('HOMEVENTORY',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: const HomesPage(),
      ),
    ),
  );
}
