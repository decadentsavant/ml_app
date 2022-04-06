import 'package:entries_api/entries_api.dart';

/// {@template entries_repository}
/// A repository that handles entry realted requests.
/// {@endtemplate}
class EntriesRepository {
  /// {@macro entries_repository}

  const EntriesRepository({
    required EntriesApi entriesApi,
  }) : _entriesApi = entriesApi;

  final EntriesApi _entriesApi;

  ///Provides a [Stream} of all entries.
  Stream<List<Entry>> getEntries() => _entriesApi.getEntries();

  ///Save an [entry]
  ///
  ///If an [entry] with with the same id already exists, it will be replaced.
  Future<void> saveEntry(Entry entry) => _entriesApi.saveEntry(entry);

  ///Deletes the entry with the given id.
  ///
  ///If no entry with the given id exits, a [EntryNotFoundException] 
  ///error is thrown.
  Future<void> deleteEntry(String id) => _entriesApi.deleteEntry(id);
}
