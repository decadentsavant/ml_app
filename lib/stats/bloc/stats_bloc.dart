import 'package:bloc/bloc.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:equatable/equatable.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({
    required EntriesRepository entriesRepository,
  })  : _entriesRepository = entriesRepository,
        super(const StatsState()) {
    on<StatsSubscriptionRequested>(_onSubscriptionRequested);
  }

  final EntriesRepository _entriesRepository;

  Future<void> _onSubscriptionRequested(
    StatsSubscriptionRequested event,
    Emitter<StatsState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.loading));

    await emit.forEach<List<Entry>>(
      _entriesRepository.getEntries(),
      onData: (entries) {
        // Begin calculating stats...
        final _currentDate = DateTime.now().toLocal();
        final _entriesCount = entries.length;
        var _activeCount = 0;
        var _archivedCount = 0;
        var _focusedSecondsTotal = 0;
        final _didMakeEntryLastSeven = <int, bool>{};
        final _didFocusLastSeven = <int, bool>{};
        final _secondsFocusedLastSeven = <int, int>{};

        for (final entry in entries) {
          // Classify entry as active or archived
          (entry.isActive) ? _activeCount += 1 : _archivedCount += 1;

          // Calculate bool value for new entry created in last 7 days
          final daysPassedSinceActivation =
              _currentDate.difference(entry.activationDate.toLocal()).inDays;

          if (daysPassedSinceActivation < 7) {
            _didMakeEntryLastSeven[daysPassedSinceActivation] = true;
          }

          entry.learningStamps.forEach((timeStamp, seconds) {
            final daysPassed =
                _currentDate.difference(timeStamp.toLocal()).inDays;
            // Calculate bool value for entry made in last 7 days
            if (daysPassed < 7) {
              _didFocusLastSeven[daysPassed] = true;
            }
            // Calcualte total seconds focused for each of last 7 days
            if (daysPassed < 7) {
              final current = _secondsFocusedLastSeven[daysPassed] ?? 0;
              _secondsFocusedLastSeven[daysPassed] = current + seconds;
            }
            // Cumulate total seconds
            _focusedSecondsTotal += seconds;
          });
        }
      return state.copyWith(
        status: StatsStatus.success,
        allEntries: _entriesCount,
        activeEntries: _activeCount,
        archivedEntries: _archivedCount,
        totalFocusTimeInSeconds: _focusedSecondsTotal,
        didMakeEntryLastSevenDays: _didMakeEntryLastSeven,
        didFocusLastSevenDays: _didFocusLastSeven,
        focusedSecondsLastSevenDays: _secondsFocusedLastSeven,
        );
      },
      onError: (_, __) => state.copyWith(status: StatsStatus.failure),
    );
  }
}
