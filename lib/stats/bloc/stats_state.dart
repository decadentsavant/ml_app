part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.totalEntries = 0,
    this.totalActiveEntries = 0,
    this.totalArchivedEntries = 0,
    this.totalEntriesMadeToday = 0,
    this.totalFocusedSecondsToday = 0,
    this.totalFocusedSecondsThisWeek = 0,
    this.totalFocusedSecondsAllTime = 0,
    this.didMakeEntryLast7Days = const {},
    this.didMakeEntryLast365Days = const {},
    this.totalFocusedSecondsEachOfLast7Days = const {},
    this.didMakeEntryAndMeetFocusGoalEachOfLast7Days = const {},
  });

  final StatsStatus status;
  final int totalEntries;
  final int totalActiveEntries;
  final int totalArchivedEntries;
  final int totalEntriesMadeToday;
  final int totalFocusedSecondsToday;
  final int totalFocusedSecondsThisWeek;
  final int totalFocusedSecondsAllTime;
  final Map<int, bool> didMakeEntryLast7Days;
  final Map<int, bool> didMakeEntryLast365Days;
  final Map<int, int> totalFocusedSecondsEachOfLast7Days;
  final Map<int, bool> didMakeEntryAndMeetFocusGoalEachOfLast7Days;

  StatsState copyWith({
    StatsStatus? status,
    int? totalEntries,
    int? totalActiveEntries,
    int? totalArchivedEntries,
    int? totalEntriesMadeToday,
    int? totalFocusedSecondsToday,
    int? totalFocusedSecondsThisWeek,
    int? totalFocusedSecondsAllTime,
    Map<int, bool>? didMakeEntryLast7Days,
    Map<int, bool>? didMakeEntryLast365Days,
    Map<int, int>? totalFocusedSecondsEachOfLast7Days,
    Map<int, bool>? didMakeEntryAndMeetFocusGoalEachOfLast7Days,
  }) {
    return StatsState(
      status: status ?? this.status,
      totalEntries: totalEntries ?? this.totalEntries,
      totalActiveEntries: totalActiveEntries ?? this.totalActiveEntries,
      totalArchivedEntries: totalArchivedEntries ?? this.totalArchivedEntries,
      totalEntriesMadeToday:
          totalEntriesMadeToday ?? this.totalEntriesMadeToday,
      totalFocusedSecondsToday:
          totalFocusedSecondsToday ?? this.totalFocusedSecondsToday,
      totalFocusedSecondsAllTime:
          totalFocusedSecondsAllTime ?? this.totalFocusedSecondsAllTime,
      didMakeEntryLast7Days:
          didMakeEntryLast7Days ?? this.didMakeEntryLast7Days,
      totalFocusedSecondsThisWeek:
          totalFocusedSecondsThisWeek ?? this.totalFocusedSecondsThisWeek,
      didMakeEntryLast365Days:
          didMakeEntryLast365Days ?? this.didMakeEntryLast365Days,
      totalFocusedSecondsEachOfLast7Days: totalFocusedSecondsEachOfLast7Days ??
          this.totalFocusedSecondsEachOfLast7Days,
      didMakeEntryAndMeetFocusGoalEachOfLast7Days:
          didMakeEntryAndMeetFocusGoalEachOfLast7Days ??
              this.didMakeEntryAndMeetFocusGoalEachOfLast7Days,
    );
  }

  @override
  List<Object> get props => [
        status,
        totalEntries,
        totalActiveEntries,
        totalArchivedEntries,
        totalEntriesMadeToday,
        totalFocusedSecondsToday,
        totalFocusedSecondsThisWeek,
        totalFocusedSecondsAllTime,
        didMakeEntryLast7Days,
        didMakeEntryLast365Days,
        totalFocusedSecondsEachOfLast7Days,
        didMakeEntryAndMeetFocusGoalEachOfLast7Days,
      ];
}
