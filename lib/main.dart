import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'itemForm.dart';

class House {
  int? homeId;
  String? homeName;
  List<Room>? rooms;

  House({this.homeId, this.homeName, this.rooms});
}

class Room {
  int? roomId;
  String? roomName;
  List<Item>? items;

  Room({this.roomId, this.roomName, this.items});
}

class Item {
  int? itemId;
  String? itemName;
  String? itemType;
  String? itemSubtype;
  String? itemBrand;
  String? itemModel;
  String? itemDimensions;
  String? itemNotes;
  File? itemImage;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    this.itemSubtype,
    this.itemBrand,
    this.itemModel,
    required this.itemDimensions,
    this.itemNotes,
    this.itemImage,
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                child: Text('Hello World'),
              ),
            ),
            SizedBox(width: 600, height: 600, child: const ItemForm()),
          ],
        ),
      ),
    );
  }
}
