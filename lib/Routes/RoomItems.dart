import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// models
// import '../models/hexCode.dart';

// widgets
// import '../widgets/navigation_drawer.dart';
import 'package:homeventory/Widgets/bottom_sheet.dart';

final style = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

class Item {
  String? itemName;
}

class RoomItemPage extends StatefulWidget {
  const RoomItemPage({Key? key}) : super(key: key);

  @override
  State<RoomItemPage> createState() => _RoomItemPageState();
}

class _RoomItemPageState extends State<RoomItemPage> {
  final _items = FirebaseFirestore.instance
      .collection('rooms')
      .doc('Tx3JL893sNa02sMsrLMO')
      .collection('items');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _items.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext ctx, index) {
            final item = items[index].data() as Map<String, dynamic>;

            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      BottomSheetWidget(item: item['itemNotes']),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(3, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    item['itemName'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
