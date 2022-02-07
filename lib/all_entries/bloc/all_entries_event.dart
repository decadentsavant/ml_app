part of 'all_entries_bloc.dart';

abstract class AllEntriesEvent extends Equatable {
  const AllEntriesEvent();

  @override
  List<Object> get props => [];
}

class AllEntriesSubscriptionRequested extends AllEntriesEvent {
  const AllEntriesSubscriptionRequested();
}

class AllEntriesEntrySaved extends AllEntriesEvent {
  const AllEntriesEntrySaved(this.entry);

  final Entry entry;

  @override
  List<Object> get props => [entry];
}

class AllEntriesIsActiveToggled extends AllEntriesEvent {
  const AllEntriesIsActiveToggled({
    required this.entry,
    required this.isActive,
  });

  final Entry entry;
  final bool isActive;

  @override
  List<Object> get props => [entry, isActive];
}

class AllEntriesEntryDeleted extends AllEntriesEvent {
  const AllEntriesEntryDeleted(this.entry);

  final Entry entry;

  @override
  List<Object> get props => [entry];
}

class AllEntriesUndoDeletionRequested extends AllEntriesEvent {
  const AllEntriesUndoDeletionRequested();
}

class AllEntriesFilterChanged extends AllEntriesEvent {
  const AllEntriesFilterChanged(this.filter);

  final AllEntriesViewFilter filter;

  @override
  List<Object> get props => [filter];
}

class AllEntriesToggleAllRequested extends AllEntriesEvent {
  const AllEntriesToggleAllRequested();
}

class AllEntriesClearCompletedRequested extends AllEntriesEvent {
  const AllEntriesClearCompletedRequested();
}
