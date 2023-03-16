import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'Theme/colorTheme.dart';


/*
Initial form is setup
Needs to add:
Styling from theme
fields clear on submit
Title changes to what is added in the name field after submit
form drawer closes on submit
Creates a new item add adds to list of items
Add edit button
Figure out how to add a form in a flutter bottom sheet


 */
import 'package:flutter/material.dart';

void main() => runApp(ItemFormPage());

class ItemFormPage extends StatelessWidget {
  const ItemFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),

      ),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(

          title: Text('Material App Bar'),
        ),
        body: Center(
          child: SizedBox(
              width: 600,
              height: 800,
              child: ItemForm()),
          ),
        ),
    );
  }
}


// void main() => runApp(ItemForm());

// class ItemForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Material App Bar'),
//         ),
//         body: Center(
//           child: Container(
//             child: Text('Hello World'),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ItemForm extends StatefulWidget {
  const ItemForm({Key? key}) : super(key: key);

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  String? _itemName;
  String? _itemType;
  String? _itemSubtype;
  String? _itemBrand;
  String? _itemModel;
  String? _itemDimensions;
  String? _notes;
  File? _imageFile;

  final _itemNameController = TextEditingController();
  final _itemTypeController = TextEditingController();
  final _itemSubtypeController = TextEditingController();
  final _itemBrandController = TextEditingController();
  final _itemModelController = TextEditingController();
  final _itemDimensionsController = TextEditingController();
  final _itemColorController = TextEditingController();
  final _notesController = TextEditingController();

  void _selectImage() async {
    // Add image selection logic here
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
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),

    ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Item'),
        ),
        body: Form(
            child: ListView(
          children: [
            TextFormField(
              controller: _itemNameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item name';
                }
                return null;
              },
              onSaved: (value) => _itemNameController.text = value!,
            ),
            TextFormField(
              controller: _itemTypeController,
              decoration: const InputDecoration(labelText: 'Item Type'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item type';
                }
                return null;
              },
              onSaved: (value) => _itemTypeController.text = value!,
            ),
            TextFormField(
              controller: _itemSubtypeController,
              decoration: const InputDecoration(labelText: 'Item Subtype'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item subtype';
                }
                return null;
              },
              onSaved: (value) => _itemSubtypeController.text = value!,
            ),
            TextFormField(
              controller: _itemBrandController,
              decoration: const InputDecoration(labelText: 'Item Brand'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item brand';
                }
                return null;
              },
              onSaved: (value) => _itemBrandController.text = value!,
            ),
            TextFormField(
              controller: _itemModelController,
              decoration: const InputDecoration(labelText: 'Item Model'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item model';
                }
                return null;
              },
              onSaved: (value) => _itemModelController.text = value!,
            ),
            TextFormField(
              controller: _itemDimensionsController,
              decoration: const InputDecoration(labelText: 'Item Dimensions'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter item dimensions';
                }
                return null;
              },
              onSaved: (value) => _itemDimensionsController.text = value!,
            ),
            TextFormField(
              controller: _notesController,
              maxLines: 6,
              decoration: const InputDecoration(
                  label: Text('Notes: ')),
              onSaved: (value) => _notes = value!,
            ),
            const ElevatedButton(onPressed: null, child: Text('Add'))
          ],
        ),
        ),
      ),
    );
  }
}
