import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

part 'todays_review_event.dart';
part 'todays_review_state.dart';

class TodaysReviewBloc extends Bloc<TodaysReviewEvent, TodaysReviewState> {
  TodaysReviewBloc({
    required EntriesRepository entriesRepository,
  })  : _entriesRepository = entriesRepository,
        super(const TodaysReviewState()) {
    on<TodaysReviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodaysReviewUrlLaunchRequested>(_onUrlLaunchRequested);
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

  Future<void> _onUrlLaunchRequested(
    TodaysReviewUrlLaunchRequested event,
    Emitter<TodaysReviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TodaysReviewStatus.loading,));
    // TODO(Corey): Handle failure states with modal or something for user.
    // Ensure validation at input level. Note: www criteria below...overkill.
    final regExp = RegExp(
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)',);
    if (event.url.isEmpty) {
      emit(state.copyWith(status: () => TodaysReviewStatus.failure));
      return;
    } else if (!regExp.hasMatch(event.url)) {
      // failure if url doesn't start with 'www'
      emit(state.copyWith(status: () => TodaysReviewStatus.failure));
      return;
    } else {
      unawaited(launch(event.url));
      emit(state.copyWith(status: () => TodaysReviewStatus.success));
      return;
    }
  }
}
