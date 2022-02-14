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
    this.monitorRelatedUrl = false,
    this.title = '',
    this.notes = '',
    this.source = '',
    this.relatedUrl = '',
    this.frequencyType = FrequencyType.periodically,
    this.frequencyInDays = const [1, 2, 4, 7, 14, 21, 30, 60, 90, 180, 365],
    this.entryPriority = EntryPriority.normal,
    this.activationDate,
    this.isActive,
  });

  final EditEntryStatus status;
  final Entry? initialEntry;
  final bool monitorRelatedUrl;
  final String? title;
  final String? notes;
  final String? source;
  final String? relatedUrl;
  final FrequencyType? frequencyType;
  final List<int>? frequencyInDays;
  final EntryPriority? entryPriority;
  final DateTime? activationDate;
  final bool? isActive;

  bool get isNewEntry => initialEntry == null;

  EditEntryState copyWith({
    EditEntryStatus? status,
    Entry? initialEntry,
    bool? monitorRelatedUrl,
    String? title,
    String? notes,
    String? source,
    String? relatedUrl,
    FrequencyType? frequencyType,
    List<int>? frequencyInDays,
    EntryPriority? entryPriority,
    DateTime? activationDate,
    bool? isActive,
  }) {
    return EditEntryState(
      status: status ?? this.status,
      initialEntry: initialEntry ?? this.initialEntry,
      monitorRelatedUrl: monitorRelatedUrl ?? this.monitorRelatedUrl,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      source: source ?? this.source,
      relatedUrl: relatedUrl ?? this.relatedUrl,
      frequencyType: frequencyType ?? this.frequencyType,
      frequencyInDays: frequencyInDays ?? this.frequencyInDays,
      entryPriority: entryPriority ?? this.entryPriority,
      activationDate: activationDate ?? this.activationDate,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        status,
        initialEntry,
        title,
        notes,
        source,
        relatedUrl,
        frequencyType,
        frequencyInDays,
        entryPriority,
        activationDate,
        isActive,
      ];
}
