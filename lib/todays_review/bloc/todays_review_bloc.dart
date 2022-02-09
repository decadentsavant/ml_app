import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todays_review_event.dart';
part 'todays_review_state.dart';

class TodaysReviewBloc extends Bloc<TodaysReviewEvent, TodaysReviewState> {
  TodaysReviewBloc() : super(TodaysReviewInitial()) {
    on<TodaysReviewEvent>((event, emit) {

    });
  }
}
