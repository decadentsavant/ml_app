part of 'edit_entry_bloc.dart';

abstract class EditEntryEvent extends Equatable {
  const EditEntryEvent();

  @override
  List<Object> get props => [];
}

class EditEntryTitleChanged extends EditEntryEvent {
  const EditEntryTitleChanged(this.title);

  final String title;

  @override 
  List<Object> get props => [title];
}

class EditEntryNotesChanged extends EditEntryEvent {
  const EditEntryNotesChanged(this.notes);

  final String notes;

  @override
  List<Object> get props => [notes];
}

class EditEntrySubmitted extends EditEntryEvent {
  const EditEntrySubmitted();
}
