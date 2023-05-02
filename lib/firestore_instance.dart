import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirestoreInstance {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static FirebaseFirestore getInstance() {
    return db;
  }

  static Future<void> setSettings(Settings settings) async {
    db.settings = settings;
  }
}
