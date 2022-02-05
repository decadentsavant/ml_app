

import 'package:entries_repository/entries_repository.dart';

enum EntriesViewFilter { all, activeOnly, archiveOnly }

extension EntriesViewFilterX on EntriesViewFilter {
  bool apply(Entry entry) {
    switch (this) {
      case EntriesViewFilter.all:
        return true;
      case EntriesViewFilter.activeOnly:
        return entry.isActive;
      case EntriesViewFilter.archiveOnly:
        return !entry.isActive;
    }
  }

  Iterable<Entry> applyAll(Iterable<Entry> entries) {
    return entries.where(apply);
  }
}
