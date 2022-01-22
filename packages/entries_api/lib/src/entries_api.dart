import 'package:entries_api/entries_api.dart';

/// {@template entry_api}
/// The interface for an API that provides access to a list of entries.
/// {@endtemplate}
abstract class EntriesApi {
  /// {@macro entry_api}
  const EntriesApi();

  /// Provides a [Stream] of all entries.
  Stream<List<Entry>> getEntries();

  /// Saves a [entry].
  ///
  /// If a [entry] with the same id already exists, it will be replaced.
  Future<void> saveEntry(Entry entry);

  /// Deletes the entry with the given id.
  ///
  /// If no entry with the given id exists, a [EntryNotFoundException] error is
  /// thrown.
  Future<void> deleteEntry(String id);

  /// Deletes all completed entries.
  ///
  /// Returns the number of deleted entries.
  Future<int> clearCompleted();

  /// Sets the `isCompleted` state of all entries to the given value.
  ///
  /// Returns the number of updated entries.
  Future<int> completeAll({required bool isCompleted});
}

/// Error thrown when a [entry] with a given id is not found.
class EntryNotFoundException implements Exception {}
