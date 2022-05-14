part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.allEntries = 0,
    this.activeEntries = 0,
    this.archivedEntries = 0,
    this.totalFocusTimeInSeconds = 0,
    this.didMakeEntryLastSevenDays = const {},
    this.didFocusLastSevenDays = const {},
    this.focusedSecondsLastSevenDays = const {},
  });

  final StatsStatus status;
  final int allEntries;
  final int activeEntries;
  final int archivedEntries;
  final int totalFocusTimeInSeconds;
  final Map<int, bool> didMakeEntryLastSevenDays;
  final Map<int, bool> didFocusLastSevenDays;
  final Map<int, int> focusedSecondsLastSevenDays;

  StatsState copyWith({
    StatsStatus? status,
    int? allEntries,
    int? activeEntries,
    int? archivedEntries,
    int? totalFocusTimeInSeconds,
    Map<int, bool>? didMakeEntryLastSevenDays,
    Map<int, bool>? didFocusLastSevenDays,
    Map<int, int>? focusedSecondsLastSevenDays,
  }) {
    return StatsState(
      status: status ?? this.status,
      allEntries: allEntries ?? this.allEntries,
      activeEntries: activeEntries ?? this.activeEntries,
      archivedEntries: archivedEntries ?? this.archivedEntries,
      totalFocusTimeInSeconds:
          totalFocusTimeInSeconds ?? this.totalFocusTimeInSeconds,
      didMakeEntryLastSevenDays:
          didMakeEntryLastSevenDays ?? this.didMakeEntryLastSevenDays,
      didFocusLastSevenDays:
          didFocusLastSevenDays ?? this.didFocusLastSevenDays,
      focusedSecondsLastSevenDays:
          focusedSecondsLastSevenDays ?? this.focusedSecondsLastSevenDays,
    );
  }

  @override
  List<Object> get props => [
        status,
        allEntries,
        activeEntries,
        archivedEntries,
        totalFocusTimeInSeconds,
        didMakeEntryLastSevenDays,
        didFocusLastSevenDays,
        focusedSecondsLastSevenDays,
      ];
}
