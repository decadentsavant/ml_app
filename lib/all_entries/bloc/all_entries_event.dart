part of 'all_entries_bloc.dart';

abstract class AllEntriesEvent extends Equatable {
  const AllEntriesEvent();

  @override
  List<Object> get props => [];
}

class AllEntriesSubscriptionRequested extends AllEntriesEvent {
  const AllEntriesSubscriptionRequested();
}

class AllEntriesQueryChanged extends AllEntriesEvent {
  const AllEntriesQueryChanged (this.query);

  final String query;

  @override
  List<Object> get props => [query];
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
