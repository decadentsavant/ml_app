import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:ml_app/todays_review/todays_review.dart';
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
    on<TodaysReviewFocusedLearningStart>(_onFocusedLearningStart);
    on<TodaysReviewFocusedLearningEnd>(_onFocusedLearningEnd);
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

    final result = await canLaunchUrl(Uri.parse(event.url));

    // 1) Trusts form validation's URL criteria
    // 2) Assumes site is accessible via https:
    // 3) Unsure if uri encode/decode is needed
    try {
      if (result) {
        await launchUrl(Uri.parse(event.url));
      } else {
        final newUrl = 'https://${event.url}';
        await launchUrl(Uri.parse(newUrl));
      }
    } catch (e) {
      // If browser suspects phishing it throws platform exception.
      // This try catch block prevents app from halting operation.
      // The browser gives UI feedback on failure. No action needed here.
      return;
    }

    emit(state.copyWith(status: () => TodaysReviewStatus.success));
  }

  void _onFocusedLearningStart(
    TodaysReviewFocusedLearningStart event,
    Emitter<TodaysReviewState> emit,
  ) {
    emit(
      state.copyWith(
        learningStart: DateTime.now().toUtc(),
      ),
    );
  }

  void _onFocusedLearningEnd(
    TodaysReviewFocusedLearningEnd event,
    Emitter<TodaysReviewState> emit,
  ) {
    emit(
      state.copyWith(
        learningEnd: DateTime.now().toUtc(),
      ),
    );
    
    final _learningStamps = Map.of(event.entry.learningStamps);
    
    // ignore: cascade_invocations
    _learningStamps.addAll({state.learningStart! : state.differentialDate!});
    
    final _modifiedEntry =
        event.entry.copyWith(learningStamps: _learningStamps);

    _entriesRepository.saveEntry(_modifiedEntry);
  }
}
