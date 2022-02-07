part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.allEntries = 0,
    this.activeEntries = 0,
    this.archivedEntries = 0,
  });

  final StatsStatus status;
  final int allEntries;
  final int activeEntries;
  final int archivedEntries;

  @override
  List<Object> get props => [
        status,
        allEntries,
        activeEntries,
        archivedEntries,
      ];

  StatsState copyWith({
    StatsStatus? status,
    int? allEntries,
    int? activeEntries,
    int? archivedEntries,
  }) {
    return StatsState(
      status: status ?? this.status,
      allEntries: allEntries ?? this.allEntries,
      activeEntries: activeEntries ?? this.activeEntries,
      archivedEntries: archivedEntries ?? this.archivedEntries,
    );
  }
}
