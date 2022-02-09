import 'package:bloc/bloc.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:equatable/equatable.dart';

part 'todays_review_event.dart';
part 'todays_review_state.dart';

class TodaysReviewBloc extends Bloc<TodaysReviewEvent, TodaysReviewState> {
  TodaysReviewBloc({
    required EntriesRepository entriesRepository,
  })  : _entriesRepository = entriesRepository,
        super(const TodaysReviewState()) {
    on<TodaysReviewSubscriptionRequested>(_onSubscriptionRequested);
  }

  final EntriesRepository _entriesRepository;

  Future<void> _onSubscriptionRequested(
    TodaysReviewSubscriptionRequested event,
    Emitter<TodaysReviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TodaysReviewStatus.loading));

    await emit.forEach<List<Entry>>(
      _entriesRepository.getEntries(),
      onData: (entries) => state.copyWith(
        status: () => TodaysReviewStatus.success,
        entries: () => entries,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TodaysReviewStatus.failure,
      ),
    );
  }

  //  Future<void> _onSubscriptionRequested(
  //   TodaysReviewSubscriptionRequested event,
  //   Emitter<TodaysReviewState> emit,
  // ) async {
  //   emit(state.copyWith(status: () => TodaysReviewStatus.loading));

  //   await emit.forEach<List<Entry>>(
  //     _entriesRepository.getEntries(),
  //     onData: (entries) => state.copyWith(
  //       status: () => TodaysReviewStatus.success,
  //       entries: () => entries,
  //     ),
  //     onError: (_, __) => state.copyWith(
  //       status: () => TodaysReviewStatus.failure,
  //     ),
  //   );
  // }

}
