import 'package:bloc/bloc.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:ml_app/all_entries/all_entries.dart';

part 'all_entries_event.dart';
part 'all_entries_state.dart';

class AllEntriesBloc extends Bloc<AllEntriesEvent, AllEntriesState> {
  AllEntriesBloc({
    required EntriesRepository entriesRepository,
  })  : _entriesRepository = entriesRepository,
        super(const AllEntriesState()) {
    on<AllEntriesSubscriptionRequested>(_onSubscriptionRequested);
    on<AllEntriesQueryChanged>(_onQueryChanged);
    on<AllEntriesIsActiveToggled>(_onIsActiveToggled);
    on<AllEntriesEntryDeleted>(_onEntryDeleted);
    on<AllEntriesUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final EntriesRepository _entriesRepository;

  Future<void> _onSubscriptionRequested(
    AllEntriesSubscriptionRequested event,
    Emitter<AllEntriesState> emit,
  ) async {
    emit(state.copyWith(status: () => AllEntriesStatus.loading));

    await emit.forEach<List<Entry>>(
      _entriesRepository.getEntries(),
      onData: (entries) => state.copyWith(
        status: () => AllEntriesStatus.success,
        entries: () => entries,
      ),
      onError: (_, __) {
       return state.copyWith(status: () => AllEntriesStatus.failure);
      },
    );
  }

  void _onQueryChanged(
    AllEntriesQueryChanged event,
    Emitter<AllEntriesState> emit,
  ) {
    emit(state.copyWith(query: event.query));
    
  }

  Future<void> _onIsActiveToggled(
    AllEntriesIsActiveToggled event,
    Emitter<AllEntriesState> emit,
  ) async {
    final newEntry = event.entry.copyWith(isActive: event.isActive);
    await _entriesRepository.saveEntry(newEntry);
  }

  Future<void> _onEntryDeleted(
    AllEntriesEntryDeleted event,
    Emitter<AllEntriesState> emit,
  ) async {
    emit(state.copyWith(lastDeletedEntry: () => event.entry));
    await _entriesRepository.deleteEntry(event.entry.id);
  }

  Future<void> _onUndoDeletionRequested(
    AllEntriesUndoDeletionRequested event,
    Emitter<AllEntriesState> emit,
  ) async {
    assert(
      state.lastDeletedEntry != null,
      'Last deleted entry can not be null.',
    );

    final entry = state.lastDeletedEntry!;
    emit(state.copyWith(lastDeletedEntry: () => null));
    await _entriesRepository.saveEntry(entry);
  }
}
