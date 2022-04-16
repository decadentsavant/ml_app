import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entries_api/entries_api.dart';

/// {@template firebase_entries_api}
/// Dart package which manages entries storage using Firebase.
/// {@endtemplate}
class FirebaseEntriesApi extends EntriesApi{
  /// {@macro firebase_entries_api}
  FirebaseEntriesApi(
    FirebaseFirestore? firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  /// Return streamed list of [Entry].
  @override
  Stream<List<Entry>> getEntries() {
    return _firebaseFirestore
    .collection('entries')
    .snapshots()
    .map((snapshot){
      return snapshot.docs.map(Entry.fromSnapshot).toList();
    });
  }

  @override
  Future<void> saveEntry(Entry entry) {
    return _firebaseFirestore
    .collection('entries')
    .add(entry.toDocument());
  }  

  @override
  Future<void> deleteEntry(String id) {
    return _firebaseFirestore
    .collection('entries')
    .doc(id)
    .delete();
  }
}
