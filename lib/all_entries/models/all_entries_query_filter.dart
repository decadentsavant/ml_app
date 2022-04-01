import 'package:entries_repository/entries_repository.dart';

Iterable<Entry> queryResults(Iterable<Entry> entries, String query) {
  final filteredAndSorted = entries.where((entry) {
    if (entry.notes.toLowerCase().contains(query.toLowerCase())) return true;
    if (entry.title.toLowerCase().contains(query.toLowerCase())) return true;
    if (entry.source != null &&
        entry.source!.toLowerCase().contains(query.toLowerCase())) {
      return true;
    }
    return false;
  }).toList()
    ..sort((a, b) => b.activationDate.compareTo(a.activationDate));
  return filteredAndSorted;
}
