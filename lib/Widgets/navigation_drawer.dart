import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Homeventory Navigation',
              style: GoogleFonts.playfairDisplay(
                textStyle: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(),
          ),
          ListTile(
            title: Text('Log In Page'),
            onTap: () {
              Get.offNamed('/');
            },
          ),
          ListTile(
            title: Text('Item Form Page'),
            onTap: () {
              Get.offNamed('/itemForm');
            },
          ),
          ListTile(
            title: Text('Room Item Page'),
            onTap: () {
              Get.offNamed('/roomItem');
            },
          ),
          ListTile(
            title: Text('Upload Item Page'),
            onTap: () {
              Get.offNamed('/uploadImage');
            },
          ),
        ],
      ),
    );
  }
}
