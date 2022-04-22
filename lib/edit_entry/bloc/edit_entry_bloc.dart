import 'package:bloc/bloc.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:ml_app/edit_entry/models/models.dart';

part 'edit_entry_event.dart';
part 'edit_entry_state.dart';

class EditEntryBloc extends Bloc<EditEntryEvent, EditEntryState> {
  EditEntryBloc({
    required EntriesRepository entriesRepository,
    required Entry? initialEntry,
  })  : _entriesRepository = entriesRepository,
        super(
          EditEntryState(
            initialEntry: initialEntry,
            title: initialEntry?.title ?? '',
            notes: initialEntry?.notes ?? '',
            source: initialEntry?.source,
            relatedUrl: initialEntry?.relatedUrl,
            frequencyType:
                initialEntry?.frequencyType ?? FrequencyType.periodically,
            frequencyInDays: initialEntry?.frequencyInDays ??
                [1, 2, 4, 7, 14, 21, 30, 60, 90, 180, 365],
            entryPriority: initialEntry?.entryPriority ?? EntryPriority.normal,
            isActive: initialEntry?.isActive ?? true,
            activationDate: initialEntry?.activationDate,
          ),
        ) {
    on<EditEntryTitleChanged>(_onTitleChanged);
    on<EditEntryNotesChanged>(_onNotesChanged);
    on<EditEntrySourceChanged>(_onSourceChanged);
    on<EditEntryRelatedUrlChanged>(_onRelatedUrlChanged);
    on<EditEntryFrequencyTypeChanged>(_onFrequencyTypeChanged);
    on<EditEntryFrequencyInDaysChanged>(_onFrequencyInDaysChanged);
    on<EditEntryEntryPriorityChanged>(_onEntryPriorityChanged);
    on<EditEntryIsActiveChanged>(_onIsActiveChanged);
    on<EditEntryActivationDateChanged>(_onActivationDateChanged);
    on<EditEntrySubmitted>(_onSubmitted);
  }

  final EntriesRepository _entriesRepository;

  void _onTitleChanged(
    EditEntryTitleChanged event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onNotesChanged(
    EditEntryNotesChanged event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(notes: event.notes));
  }

  void _onSourceChanged(
    EditEntrySourceChanged event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(source: event.source));
  }

  void _onRelatedUrlChanged(
    EditEntryRelatedUrlChanged event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(relatedUrl: event.relatedUrl));
  }

  void _onFrequencyTypeChanged(
    EditEntryFrequencyTypeChanged event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(frequencyType: event.frequencyType));
  }

  void _onFrequencyInDaysChanged(
    EditEntryFrequencyInDaysChanged event,
    Emitter<EditEntryState> emit,
  ) {
    // Replace string with sorted list of integers
    final digitsOnly = RegExp('[^0-9]+');
    final toListOfStrings =
        event.frequencyInDays.replaceAll(digitsOnly, ' ').split(' ');
    final parsed = <int>[];
    for (final x in toListOfStrings) {
      if (x.isNotEmpty) {
        parsed.add(int.parse(x));
      }
    }
    parsed.sort();

    emit(state.copyWith(frequencyInDays: parsed));
  }

  void _onEntryPriorityChanged(
    EditEntryEntryPriorityChanged event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(entryPriority: event.entryPriority));
  }

  void _onIsActiveChanged(
    EditEntryIsActiveChanged event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(isActive: event.isActive));
  }

  void _onActivationDateChanged(
    EditEntryActivationDateChanged event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(activationDate: event.activationDate));
  }

  void _onSubmitted(
    EditEntrySubmitted event,
    Emitter<EditEntryState> emit,
  ) {
    emit(state.copyWith(status: EditEntryStatus.loading));

    // If one of the checks fails, start monitorig and give UI feedback
    if (!isValidTitleOrNotes(string: state.title!) ||
        !isValidTitleOrNotes(string: state.notes!) ||
        !isValidFrequencyInDays(
          integers: state.frequencyInDays!,
          frequencyType: state.frequencyType!,
        ) ||
        (state.relatedUrl != null && !isValidURL(state.relatedUrl!))) {
      emit(
        state.copyWith(
          monitor: true,
          status: EditEntryStatus.initial,
        ),
      );
      return;
    }

    final entry = (state.initialEntry ??
            Entry(
              title: '',
              notes: '',
            ))
        .copyWith(
      title: state.title,
      notes: state.notes,
      source: state.source,
      relatedUrl: state.relatedUrl?.trim(),
      frequencyType: state.frequencyType,
      // toSet() -> .toList() to remove any duplicates
      frequencyInDays: state.frequencyInDays?.toSet().toList(),
      entryPriority: state.entryPriority,
      activationDate: state.activationDate,
      isActive: state.isActive,
    );

    try {
      _entriesRepository.saveEntry(entry);
      emit(state.copyWith(status: EditEntryStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditEntryStatus.failure));
    }
  }
}
