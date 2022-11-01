import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_entries_api/firebase_entries_api.dart';
import 'package:flutter/material.dart';
import 'package:ml_app/bootstrap.dart';
import 'package:ml_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final instance = FirebaseFirestore.instance;

  bootstrap(entriesApi: FirebaseEntriesApi(instance));
}
