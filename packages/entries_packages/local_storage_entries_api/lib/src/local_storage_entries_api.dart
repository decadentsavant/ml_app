import 'dart:async';
import 'dart:convert';

import 'package:entries_api/entries_api.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_storage_entries_api}
/// A Flutter implementation of the [EntriesApi] that uses local storage.
/// {@endtemplate}
class LocalStorageEntriesApi extends EntriesApi {
  /// {@macro local_storage_entries_api}
  LocalStorageEntriesApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _entryStreamController = BehaviorSubject<List<Entry>>.seeded(const []);

  /// The key used for storing the entries locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kEntriesCollectionKey = '__entries_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final entriesJson = _getValue(kEntriesCollectionKey);
    if (entriesJson != null) {
      final entries = List<Map>.from(json.decode(entriesJson) as List)
          .map((jsonMap) => Entry.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _entryStreamController.add(entries);
    } else {
      _entryStreamController.add(const []);
    }
  }

  @override
  Stream<List<Entry>> getEntries() =>
      _entryStreamController.asBroadcastStream();

  @override
  Future<void> saveEntry(Entry entry) {
    final entries = [..._entryStreamController.value];
    final entryIndex = entries.indexWhere((t) => t.id == entry.id);
    if (entryIndex >= 0) {
      entries[entryIndex] = entry;
    } else {
      entries.add(entry);
    }

    _entryStreamController.add(entries);
    return _setValue(kEntriesCollectionKey, json.encode(entries));
  }

  @override
  Future<void> deleteEntry(String id) async {
    final entries = [..._entryStreamController.value];
    final entryIndex = entries.indexWhere((e) => e.id == id);
    if (entryIndex == -1) {
      throw EntryNotFoundException();
    } else {
      entries.removeAt(entryIndex);
      _entryStreamController.add(entries);
      return _setValue(kEntriesCollectionKey, json.encode(entries));
    }
  }
}
