import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:homeventory/classes.dart';
import 'package:firebase_database/firebase_database.dart';



class House {
  int? homeId;
  String? homeName;
  List<Room>? rooms;

  House({this.homeId, this.homeName, this.rooms});
}

House createHouse(int id, String name, List<Room> rooms) {
  return House(homeId: id, homeName: name, rooms: rooms);
}

final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();
DatabaseReference ref = FirebaseDatabase.instance.ref();




List<House> _homes = [];

List<Room> _rooms = [];

House house = House(homeId: 1, homeName: 'Eds', rooms: _rooms);

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('HOMEVENTORY'),
        ),
        body: GridView.builder(
          itemCount: 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 20,
              height: 50,
              child: ListTile(
                tileColor: Colors.amber,
                onTap: () {

                },

              ),
            );
          },
        ),
      ),
    );
  }
}




















