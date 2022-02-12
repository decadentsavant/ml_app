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
    emit(
      state.copyWith(
        status: () => TodaysReviewStatus.loading,
      ),
    );

  // TODO(Corey): This code still has problems with some sites.
  // MostLearned.com for some reason; Google thinks its phishing and the OS 
  // returns a platform error. Poorly formatted addresses fail as well. 
  // For example, the string 'google' without the '.com'. Can be overcome with
  // form validation, but don't copy paste this and it expect it to 
  // work everywhere.
    final result = await canLaunch(event.url);
    if (!result) {
      emit(state.copyWith(status: () => TodaysReviewStatus.failure));
    }
    if (result) {
      if (event.url.contains('http://') || event.url.contains('https://')) {
        await launch(event.url);
      }
    } else {
      final newUrl = 'https://${event.url}';
      await launch(newUrl);
    }

    emit(state.copyWith(status: () => TodaysReviewStatus.success));
  }
}
