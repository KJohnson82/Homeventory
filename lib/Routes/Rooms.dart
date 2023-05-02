import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Theme/colorTheme.dart';
import 'Rooms.dart';
import '../main.dart';

//Creating a Rooms Page...

class Room {
  String? roomName;
  Map<Object, Room>? rooms;

  Room({this.roomName, Map<int, Room>? rooms}) {
    this.rooms = rooms ?? {};
  }
}

class RoomPage extends StatefulWidget {
  const RoomPage({super.key, required roomId, required roomName});

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final _room = db.collection("rooms");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roomNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int roomCount = 0;

  // static get db => null;

// Adds a new Room Object
  void _addRoom() async {
    if (_formKey.currentState!.validate()) {
      await _room.add({
        'roomName': _roomNameController.text,
      });
      _roomNameController.clear();
      Navigator.of(context).pop();
      setState(() {});
      roomCount = roomCount + 1;
    }
  }

  void _editRoom(String documentId, String newName) async {
    if (_formKey.currentState!.validate()) {
      await _room.doc(documentId).update({
        'roomName': newName.toUpperCase(),
      });
      _roomNameController.clear();
      setState(() {});
    }
  }

  void updateRoomCount(int count) async {
    await Future.delayed(const Duration(milliseconds: 3));
    setState(() {
      roomCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _room.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final rooms = snapshot.data!.docs;
          updateRoomCount(rooms.length);

          return GridView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            itemCount: rooms.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: RoomPage(
                            roomId: rooms[index].id,
                            roomName: rooms[index]['roomName'],
                          ),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 300)));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              title: Text(
                                  'Edit or Delete ${rooms[index]["RoomName"]}?'),
                              content: Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: _roomNameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Edit: Room Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a Room name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Confirm'),
                                  onPressed: () {
                                    String documentId = rooms[index].id;
                                    _editRoom(
                                        documentId, _roomNameController.text);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    String documentId = rooms[index].id;
                                    db
                                        .collection('rooms')
                                        .doc(documentId)
                                        .delete();
                                    _roomNameController.clear();
                                    Navigator.of(context).pop();
                                    updateRoomCount(roomCount - 1);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Card(
                    elevation: 8,
                    color: Colors.transparent,
                    shadowColor: homeventory.background,
                    surfaceTintColor: Colors.transparent,
                    child: Container(
                      height: 50,
                      width: 50,
                      // color: homeventory.secondary,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: homeventory.secondary,
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: const [
                        //   BoxShadow(
                        //       color: Colors.black12,
                        //       spreadRadius: 1,
                        //       blurRadius: 10,
                        //       offset: Offset(2, 6))
                        // ],
                        shape: BoxShape.rectangle,
                      ),
                      child: Text(
                        rooms[index]['RoomName'],
                        style: TextStyle(
                          color: homeventory.onSecondary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoogleFonts.poppins()",
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // elevation: 3,
        onPressed: roomCount < 3
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add A New Room'),
                      content: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _roomNameController,
                          decoration:
                              const InputDecoration(labelText: 'Room Name'),
                          focusNode: _focusNode,
                          autofocus: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Room name';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            _addRoom();
                            _roomNameController.clear();
                          },
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Save'),
                          onPressed: () {
                            _addRoom();
                            _roomNameController.clear();
                            // Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            : () {},
        child: const Icon(
          Icons.add_box_outlined,
          size: 50,
          // color: homeventory.primary,
        ),
      ),
    );
  }
}
