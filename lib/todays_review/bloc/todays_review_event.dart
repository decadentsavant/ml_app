part of 'todays_review_bloc.dart';

abstract class TodaysReviewEvent extends Equatable {
  const TodaysReviewEvent();

  @override
  List<Object> get props => [];
}

class TodaysReviewSubscriptionRequested extends TodaysReviewEvent {
  const TodaysReviewSubscriptionRequested();
}
class TodaysReviewUrlLaunchRequested extends TodaysReviewEvent {
  const TodaysReviewUrlLaunchRequested(this.url);

  final String url;

  @override 
  List<Object> get props => [url];
}

class TodaysReviewFocusedLearningStart extends TodaysReviewEvent {
  const TodaysReviewFocusedLearningStart(this.entry);

  final Entry entry;

  @override
  List<Object> get props => [entry];
}

class TodaysReviewFocusedLearningEnd extends TodaysReviewEvent {
  const TodaysReviewFocusedLearningEnd(this.entry);

  final Entry entry;

  @override
  List<Object> get props => [entry];
}
