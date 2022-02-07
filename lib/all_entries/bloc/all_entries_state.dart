part of 'all_entries_bloc.dart';

abstract class AllEntriesState extends Equatable {
  const AllEntriesState();
  
  @override
  List<Object> get props => [];
}

class AllEntriesInitial extends AllEntriesState {}
