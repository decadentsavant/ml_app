part of 'edit_entry_bloc.dart';

enum EditEntryStatus { initial, loading, success, failure }

extension EditEntryStatusX on EditEntryStatus {
  bool get isLoadingOrSuccess => [
        EditEntryStatus.loading,
        EditEntryStatus.success,
      ].contains(this);
}

class EditEntryState extends Equatable {
  const EditEntryState({
    this.status = EditEntryStatus.initial,
    this.initialEntry,
    this.title = '',
    this.notes = '',
  });

  final EditEntryStatus status;
  final Entry? initialEntry;
  final String title;
  final String notes;

  bool get isNewEntry => initialEntry == null;

  EditEntryState copyWith({
    EditEntryStatus? status,
    Entry? initialEntry,
    String? title,
    String? notes,
  }) {
    return EditEntryState(
      status: status ?? this.status,
      initialEntry: initialEntry ?? this.initialEntry,
      title: title ?? this.title,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [status, initialEntry, title, notes];
}
