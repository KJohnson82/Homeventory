import 'package:flutter/material.dart';
import 'main.dart';

class HomeList extends StatelessWidget {
  // const HomeList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: itemBuilder,
    );
  }
}
