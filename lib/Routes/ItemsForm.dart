import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'RoomItems.dart';

class Item {
  int? itemId;
  String? itemName;
  String? itemType;
  String? itemSubtype;
  String? itemBrand;
  String? itemModel;
  String? itemDimensions;
  String? itemColor;
  String? itemNotes;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    this.itemSubtype,
    this.itemBrand,
    this.itemModel,
    this.itemDimensions,
    this.itemColor,
    this.itemNotes,
  });


  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemType': itemType,
      'itemSubtype': itemSubtype,
      'itemBrand': itemBrand,
      'itemModel': itemModel,
      'itemDimensions': itemDimensions,
      'itemColor': itemColor,
      'itemNotes': itemNotes,
    };
  }


  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      itemId: map['itemId'],
      itemName: map['itemName'],
      itemType: map['itemType'],
      itemSubtype: map['itemSubtype'],
      itemBrand: map['itemBrand'],
      itemModel: map['itemModel'],
      itemDimensions: map['itemDimensions'],
      itemColor: map['itemColor'],
      itemNotes: map['itemNotes'],
    );
  }
}

class ItemForm extends StatefulWidget {
  final String roomId;

  ItemForm({super.key, required this.roomId});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemTypeController = TextEditingController();
  TextEditingController _itemSubtypeController = TextEditingController();
  TextEditingController _itemBrandController = TextEditingController();
  TextEditingController _itemModelController = TextEditingController();
  TextEditingController _itemDimensionsController = TextEditingController();
  TextEditingController _itemColorController = TextEditingController();
  TextEditingController _itemNotesController = TextEditingController();

  void _addItem() async {
    if (_formKey.currentState!.validate()) {
      await _firestore
          .collection('rooms')
          .doc(widget.roomId)
          .collection('items')
          .add({
        'itemName': _itemNameController.text,
        'itemType': _itemTypeController.text,
        'itemSubtype': _itemSubtypeController.text,
        'itemBrand': _itemBrandController.text,
        'itemModel': _itemModelController.text,
        'itemDimensions': _itemDimensionsController.text,
        'itemColor': _itemColorController.text,
        'itemNotes': _itemNotesController.text,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _itemTypeController,
                decoration: const InputDecoration(labelText: 'Item Type'),
              ),
              TextFormField(
                controller: _itemSubtypeController,
                decoration: const InputDecoration(labelText: 'Item Subtype'),
              ),
              TextFormField(
                controller: _itemBrandController,
                decoration: const InputDecoration(labelText: 'Item Brand'),
              ),
              TextFormField(
                controller: _itemModelController,
                decoration: const InputDecoration(labelText: 'Item Model'),
              ),
              TextFormField(
                controller: _itemDimensionsController,
                decoration: const InputDecoration(labelText: 'Item Dimensions'),
              ),
              TextFormField(
                controller: _itemColorController,
                decoration: const InputDecoration(labelText: 'Item Color'),
              ),
              TextFormField(
                controller: _itemNotesController,
                decoration: const InputDecoration(labelText: 'Item Notes'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addItem,
                child: const Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemTypeController.dispose();
    _itemSubtypeController.dispose();
    _itemBrandController.dispose();
    _itemModelController.dispose();
    _itemDimensionsController.dispose();
    _itemColorController.dispose();
    _itemNotesController.dispose();
    super.dispose();
  }
}
