// import 'dart:html';
import 'package:flutter/material.dart';
// import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'itemForm.dart';
import 'Theme/colorTheme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
// import 'package:google_fonts/google_fonts.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      theme: FlexThemeData.dark(),
      title: 'HOMVENTORY',
      home: Scaffold(
        bottomNavigationBar: const BottomAppBar(
          elevation: 2,
          notchMargin: 10,
          shape: AutomaticNotchedShape(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                )),
            StadiumBorder(),
          ),
        ),
        appBar: AppBar(
          title: const Text('HOMEVENTORY'),
          centerTitle: true,
        ),
        body: HomesPage(),
      ),
    ),
  );
}

