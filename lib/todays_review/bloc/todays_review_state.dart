part of 'todays_review_bloc.dart';

enum TodaysReviewStatus { initial, loading, success, failure }

class TodaysReviewState extends Equatable {
  const TodaysReviewState({
    this.status = TodaysReviewStatus.initial,
    this.entries = const [],
    this.learningStart,
    this.learningEnd,
  });

  final TodaysReviewStatus status;
  final List<Entry> entries;
  final DateTime? learningStart;
  final DateTime? learningEnd;

  Iterable<Entry> get filteredEntries =>
      createTodaysReviewList(entries: entries);

  int? get differentialDate =>
      learningEnd?.difference(learningStart!).inSeconds;

  TodaysReviewState copyWith({
    TodaysReviewStatus Function()? status,
    List<Entry> Function()? entries,
    DateTime? learningStart,
    DateTime? learningEnd,
  }) {
    return TodaysReviewState(
      entries: entries != null ? entries() : this.entries,
      status: status != null ? status() : this.status,
      learningStart: learningStart ?? this.learningStart,
      learningEnd: learningEnd ?? this.learningEnd,
    );
  }

  @override
  List<Object?> get props => [status, entries, learningStart, learningEnd];
}
