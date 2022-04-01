part of 'all_entries_bloc.dart';

enum AllEntriesStatus { initial, loading, success, failure }

extension AllEntriesStatusX on AllEntriesStatus {
  bool get isSuccess => [AllEntriesStatus.success].contains(this);
}

class AllEntriesState extends Equatable {
  const AllEntriesState({
    this.status = AllEntriesStatus.initial,
    this.entries = const [],
    this.query = '',
    this.lastDeletedEntry,
  });

  final AllEntriesStatus status;
  final List<Entry> entries;
  final String query;
  final Entry? lastDeletedEntry;

  Iterable<Entry> get queriedEntries => queryResults(entries, query);

  

  AllEntriesState copyWith({
    AllEntriesStatus Function()? status,
    List<Entry> Function()? entries,
    String? query,
    Entry? Function()? lastDeletedEntry,
  }) {
    return AllEntriesState(
      status: status != null ? status() : this.status,
      entries: entries != null ? entries() : this.entries,
      query: query ?? this.query,
      lastDeletedEntry:
          lastDeletedEntry != null ? lastDeletedEntry() : this.lastDeletedEntry,
    );
  }

  @override
  List<Object?> get props => [
        status,
        entries,
        query,
        lastDeletedEntry,
      ];
}
