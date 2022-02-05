part of 'all_entries_bloc.dart';

@immutable
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

class AllEntriesEntrySelected extends AllEntriesEvent {
  const AllEntriesEntrySelected(this.entry);

  final Entry entry;

  @override 
  List<Object> get props => [entry];
}

class AllEntriesEntryDeleted extends AllEntriesEvent {
  const AllEntriesEntryDeleted(this.entry);

  final Entry entry;

  @override 
  List<Object> get props => [entry];

}

class AllEntriesEntryIsActiveToggled extends AllEntriesEvent {
  const AllEntriesEntryIsActiveToggled({
    required this.entry,
    required this.isActive,
  });

  final Entry entry;
  final bool isActive;

  @override 
  List<Object> get props => [entry, isActive];
}

class AllEntriesUndoDeletionRequested extends AllEntriesEvent {
  const AllEntriesUndoDeletionRequested();
}

class AllEntriesFilterChanged extends AllEntriesEvent {
  const AllEntriesFilterChanged(this.filter);

  final EntriesViewFilter filter; 

  @override
  List<Object> get props => [filter];
}

class AllEntriesSearch extends AllEntriesEvent {
  // TODO(Corey): Add logic;
}
