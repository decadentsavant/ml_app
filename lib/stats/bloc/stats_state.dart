part of 'stats_bloc.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState extends Equatable {
  const StatsState({
    this.status = StatsStatus.initial,
    this.totalEntries = 0,
    this.activeEntries = 0,
    this.archivedEntries = 0,
  });

  final StatsStatus status;
  final int totalEntries;
  final int activeEntries;
  final int archivedEntries;

  @override
  List<Object> get props => [
        status,
        totalEntries,
        activeEntries,
        archivedEntries,
      ];

  StatsState copyWith({
    StatsStatus? status,
    int? totalEntries,
    int? activeEntries,
    int? archivedEntries,
  }) {
    return StatsState(
      status: status ?? this.status,
      totalEntries: totalEntries ?? this.totalEntries,
      activeEntries: activeEntries ?? this.activeEntries,
      archivedEntries: archivedEntries ?? this.archivedEntries,
    );
  }
}
