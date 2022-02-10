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
