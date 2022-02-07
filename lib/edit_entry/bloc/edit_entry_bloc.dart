import 'package:bloc/bloc.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:equatable/equatable.dart';

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
          ),
        ) {
    on<EditEntryTitleChanged>(_onTitleChanged);
    on<EditEntryNotesChanged>(_onNotesChanged);
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

  Future<void> _onSubmitted(
    EditEntrySubmitted event,
    Emitter<EditEntryState> emit,
  ) async {
    emit(state.copyWith(status: EditEntryStatus.loading));
    final entry = (state.initialEntry ?? Entry(title: '', notes: '',)).copyWith(
      title: state.title,
      notes: state.notes,
    );

    try {
      await _entriesRepository.saveEntry(entry);
      emit(state.copyWith(status: EditEntryStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditEntryStatus.failure));
    }
  }
}
