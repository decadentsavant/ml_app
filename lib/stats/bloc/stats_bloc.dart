import 'package:bloc/bloc.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:ml_app/stats/stats.dart';

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
        final _now = DateTime.now().toLocal();

        final _totalEntries = entries.length;
        var _totalActiveEntries = 0;
        var _totalArchivedEntries = 0;
        var _totalEntriesMadeToday = 0;
        var _totalFocusedSecondsToday = 0;
        var _totalFocusedSecondsThisWeek = 0;
        var _totalFocusedSecondsAllTime = 0;
        final _didMakeEntryLast7Days = <int, bool>{};
        final _didMakeEntryLast365Days = <int, bool>{};
        final _totalFocusedSecondsEachOfLast7Days = <int, int>{};
        final _totalFocusedSecondsEachOfLast365Days = <int, int>{};
        final _didMakeEntryAndMeetFocusGoalEachOfLast7Days = <int, bool>{};

        for (final entry in entries) {
          final _activationDateLocal = entry.activationDate.toLocal();

          // Obtain difference in days since learning activation
          final daysPassedSinceActivation =
              DateUtility.daysBetween(_activationDateLocal, _now);

          // Classify entry as active or archived
          (entry.isActive)
              ? _totalActiveEntries += 1
              : _totalArchivedEntries += 1;

          // Calculate bool map for new entry created in last 365 days
          if (daysPassedSinceActivation < 365) {
            _didMakeEntryLast365Days[daysPassedSinceActivation] = true;
            // Calculate bool map for new entry created in last 7 days
            if (daysPassedSinceActivation < 7) {
              _didMakeEntryLast7Days[daysPassedSinceActivation] = true;
              // Running total of entries made today
              if (daysPassedSinceActivation == 0) {
                _totalEntriesMadeToday += 1;
              }
            }
          }

          // Begin examining learning time stamps...
          entry.learningStamps.forEach(
            (timeStamp, seconds) {
              final timeStampLocal = timeStamp.toLocal();
              
              // Obtain difference in days since focused time
              final daysPassedSinceFocusedTime =
                  DateUtility.daysBetween(timeStampLocal, _now);

              // Running total of focused seconds
              _totalFocusedSecondsAllTime += seconds;

              // Calculate total seconds for entry made in last 365 days
              if (daysPassedSinceFocusedTime < 365) {
                var _sum = _totalFocusedSecondsEachOfLast365Days[
                        daysPassedSinceFocusedTime] ??
                    0;
                _sum += seconds;
                _totalFocusedSecondsEachOfLast365Days[
                    daysPassedSinceFocusedTime] = _sum;
                // Calculate total seconds for entry made in last 7 days
                if (daysPassedSinceFocusedTime < 7) {
                  var _sum = _totalFocusedSecondsEachOfLast7Days[
                          daysPassedSinceFocusedTime] ??
                      0;
                  _sum += seconds;
                  _totalFocusedSecondsEachOfLast7Days[
                      daysPassedSinceFocusedTime] = _sum;
                }
                // Running total of seconds focused today
                if (daysPassedSinceFocusedTime == 0) {
                  _totalFocusedSecondsToday += seconds;
                }

                // Calculate focused seconds this week
                if (timeStampLocal.isAfter(DateUtility.mostRecentMonday())) {
                  _totalFocusedSecondsThisWeek += seconds;
                }
              }
            },
          );

          // Calcualte bool map for adding entry AND meeting focus goal
          _didMakeEntryLast7Days.forEach(
            (key1, value1) {
              if (value1 == true) {
                _totalFocusedSecondsEachOfLast7Days.forEach(
                  (key2, value2) {
                    if ((key1 == key2) && (value2 >= 300)) {
                      _didMakeEntryAndMeetFocusGoalEachOfLast7Days[key1] = true;
                    }
                  },
                );
              }
            },
          );
        }
        return state.copyWith(
          status: StatsStatus.success,
          totalEntries: _totalEntries,
          totalActiveEntries: _totalActiveEntries,
          totalArchivedEntries: _totalArchivedEntries,
          totalEntriesMadeToday: _totalEntriesMadeToday,
          totalFocusedSecondsToday: _totalFocusedSecondsToday,
          totalFocusedSecondsThisWeek: _totalFocusedSecondsThisWeek,
          totalFocusedSecondsAllTime: _totalFocusedSecondsAllTime,
          didMakeEntryLast7Days: _didMakeEntryLast7Days,
          didMakeEntryLast365Days: _didMakeEntryLast365Days,
          totalFocusedSecondsEachOfLast7Days:
              _totalFocusedSecondsEachOfLast7Days,
          didMakeEntryAndMeetFocusGoalEachOfLast7Days:
              _didMakeEntryAndMeetFocusGoalEachOfLast7Days,
        );
      },
      onError: (_, __) => state.copyWith(status: StatsStatus.failure),
    );
  }
}
