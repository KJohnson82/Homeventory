import 'package:flutter/material.dart';
import 'package:homeventory/Routes/ItemsForm.dart';

class BottomSheetWidget extends StatelessWidget {
  final Item item;

  const BottomSheetWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFE5F55),
                  ),
                  child: const Text('Close Item'),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Name: ${item.itemName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Type: ${item.itemType}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Subtype: ${item.itemSubtype}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Brand: ${item.itemBrand}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Model: ${item.itemModel}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Dimensions: ${item.itemDimensions}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Expanded(
              child: Text(
                'Notes: ${item.itemNotes}',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Color: ${item.itemColor}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
