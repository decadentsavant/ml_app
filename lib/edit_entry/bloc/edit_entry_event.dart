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

class EditEntrySourceChanged extends EditEntryEvent {
  const EditEntrySourceChanged(this.source);

  final String source;

  @override
  List<Object> get props => [source];
}

class EditEntryRelatedUrlChanged extends EditEntryEvent {
  const EditEntryRelatedUrlChanged(this.relatedUrl);

  final String relatedUrl;

  @override
  List<Object> get props => [relatedUrl];
}

class EditEntryFrequencyTypeChanged extends EditEntryEvent {
  const EditEntryFrequencyTypeChanged(this.frequencyType);

  final FrequencyType frequencyType;

  @override
  List<Object> get props => [frequencyType];
}

class EditEntryFrequencyInDaysChanged extends EditEntryEvent {
  const EditEntryFrequencyInDaysChanged(this.frequencyInDays);

  final String frequencyInDays;

  @override
  List<Object> get props => [frequencyInDays];
}

class EditEntryEntryPriorityChanged extends EditEntryEvent {
  const EditEntryEntryPriorityChanged(this.entryPriority);

  final EntryPriority entryPriority;

  @override
  List<Object> get props => [entryPriority];
}

class EditEntryIsActiveChanged extends EditEntryEvent {
  const EditEntryIsActiveChanged({required this.isActive});

  final bool isActive;

  @override
  List<Object> get props => [isActive];
}

class EditEntryActivationDateChanged extends EditEntryEvent {
  const EditEntryActivationDateChanged(this.activationDate);

  final DateTime activationDate;

  @override
  List<Object> get props => [activationDate];
}

class EditEntrySubmitted extends EditEntryEvent {
  const EditEntrySubmitted();
}
