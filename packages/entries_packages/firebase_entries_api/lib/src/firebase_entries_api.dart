import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entries_api/entries_api.dart';

/// {@template firebase_entries_api}
/// Dart package which manages entries storage using Firebase.
/// {@endtemplate}
class FirebaseEntriesApi extends EntriesApi {
  /// {@macro firebase_entries_api}
  FirebaseEntriesApi(
    FirebaseFirestore? firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  final _entryStreamController = FirebaseFirestore.instance
      .collection('entries')
      .withConverter<Entry>(
        fromFirestore: (snapshot, _) => Entry.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      )
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  /// Transforms a [CollectionReference] to manipulate a custom object instead
  /// of a `Map<String, dynamic>`. This makes both read and write operations
  /// type-safe.
  final modelsRef =
      FirebaseFirestore.instance.collection('entries').withConverter<Entry>(
            fromFirestore: (snapshot, _) => Entry.fromJson(snapshot.data()!),
            toFirestore: (entry, _) => entry.toJson(),
          );

  // Overrides

  /// Return streamed list of [Entry] from Firestore.
  @override
  Stream<List<Entry>> getEntries() {
    print('this was called');
    return _entryStreamController;
  }

  /// Save a single [Entry] to Firestore.
  @override
  Future<void> saveEntry(Entry entry) {
    return modelsRef.doc(entry.id).set(entry);
  }

  /// Delete a single [Entry] from Firestore.
  @override
  Future<void> deleteEntry(String id) {
    return _firebaseFirestore.collection('entries').doc(id).delete();
  }
}
