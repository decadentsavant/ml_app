import 'package:entries_repository/entries_repository.dart';

enum AllEntriesViewFilter { all, activeOnly, archiveOnly }

extension AllEntriesViewFilterX on AllEntriesViewFilter {
  bool apply(Entry entry) {
    switch (this) {
      case AllEntriesViewFilter.all:
        return true;
      case AllEntriesViewFilter.activeOnly:
        return entry.isActive;
      case AllEntriesViewFilter.archiveOnly:
        return !entry.isActive;
    }
  }

  Iterable<Entry> applyAll(Iterable<Entry> entries) {
    final filteredAndSorted = entries.where(apply).toList()
      ..sort((a, b) => b.activationDate.compareTo(a.activationDate));
    return filteredAndSorted;
  }
}
