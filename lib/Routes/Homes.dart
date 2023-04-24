import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Theme/colorTheme.dart';
import 'Rooms.dart';
import '../../main.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'Rooms.dart';

var homeCount = 0;

class Home {
  String? homeName;
  Map<Object, Room>? rooms;

  Home({this.homeName, Map<int, Room>? rooms}) {
    this.rooms = rooms ?? {};
  }
}

class HomesPage extends StatefulWidget {
  const HomesPage({super.key});

  @override
  _HomesPageState createState() => _HomesPageState();
}

class _HomesPageState extends State<HomesPage> {
  final _homes = db.collection("homes");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _homeNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int homeCount = 0;

// Adds a new Home Object
  void _addHome() async {
    if (_formKey.currentState!.validate()) {
      await _homes.add({
        'homeName': _homeNameController.text,
      });
      _homeNameController.clear();
      Navigator.of(context).pop();
      setState(() {});
      homeCount = homeCount + 1;
    }
  }

  void _editHome(String documentId, String newName) async {
    if (_formKey.currentState!.validate()) {
      await _homes.doc(documentId).update({
        'homeName': newName.toUpperCase(),
      });
      _homeNameController.clear();
      setState(() {});
    }
  }

  void updateHomeCount(int count) async {
    await Future.delayed(const Duration(milliseconds: 3));
    setState(() {
      homeCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _homes.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final homes = snapshot.data!.docs;
          updateHomeCount(homes.length);

          return GridView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            itemCount: homes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: RoomsPage(
                            homeId: homes[index].id,
                            homeName: homes[index]['homeName'],
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
                                  'Edit or Delete ${homes[index]["homeName"]}?'),
                              content: Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: _homeNameController,
                                  decoration: InputDecoration(
                                      labelText: 'Edit: Home Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Confirm'),
                                  onPressed: () {
                                    String documentId = homes[index].id;
                                    _editHome(
                                        documentId, _homeNameController.text);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    String documentId = homes[index].id;
                                    db
                                        .collection('homes')
                                        .doc(documentId)
                                        .delete();
                                    _homeNameController.clear();
                                    Navigator.of(context).pop();
                                    updateHomeCount(homeCount - 1);
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
                        homes[index]['homeName'],
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
        onPressed: homeCount < 3
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add A New Home'),
                      content: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _homeNameController,
                          decoration:
                              const InputDecoration(labelText: 'Home Name'),
                          focusNode: _focusNode,
                          autofocus: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            _addHome();
                            _homeNameController.clear();
                          },
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Save'),
                          onPressed: () {
                            _addHome();
                            _homeNameController.clear();
                            // Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            : () {},
        child: Icon(
          Icons.add_home_outlined,
          size: 50,
          // color: homeventory.primary,
        ),
      ),
    );
  }
}
