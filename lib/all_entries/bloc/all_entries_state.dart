part of 'all_entries_bloc.dart';

enum AllEntriesStatus { initial, loading, success, failure }

class AllEntriesState extends Equatable {
  const AllEntriesState({
    this.status = AllEntriesStatus.initial,
    this.entries = const [],
    this.filter = AllEntriesViewFilter.all,
    this.lastDeletedEntry,
  });

  final AllEntriesStatus status;
  final List<Entry> entries;
  final AllEntriesViewFilter filter;
  final Entry? lastDeletedEntry;

  Iterable<Entry> get filteredEntries => filter.applyAll(entries);

  AllEntriesState copyWith({
    AllEntriesStatus Function()? status,
    List<Entry> Function()? entries,
    AllEntriesViewFilter Function()? filter,
    Entry? Function()? lastDeletedEntry,
  }) {
    return AllEntriesState(
      status: status != null ? status() : this.status,
      entries: entries != null ? entries() : this.entries,
      filter: filter != null ? filter() : this.filter,
      lastDeletedEntry:
          lastDeletedEntry != null ? lastDeletedEntry() : this.lastDeletedEntry,
    );
  }

  @override
  List<Object?> get props => [
        status,
        entries,
        filter,
        lastDeletedEntry,
      ];
}
