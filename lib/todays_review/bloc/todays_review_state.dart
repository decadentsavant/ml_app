part of 'todays_review_bloc.dart';

enum TodaysReviewStatus { initial, loading, success, failure }

class TodaysReviewState extends Equatable {
  const TodaysReviewState({
    this.status = TodaysReviewStatus.initial,
    this.entries = const [],
  });

  final TodaysReviewStatus status;
  final List<Entry> entries;

  Iterable<Entry> get filteredEntries =>
      createTodaysReviewList(entries: entries);

  TodaysReviewState copyWith({
    TodaysReviewStatus Function()? status,
    List<Entry> Function()? entries,
  }) {
    return TodaysReviewState(
      entries: entries != null ? entries() : this.entries,
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [status, entries];
}
