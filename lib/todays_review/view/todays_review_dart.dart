import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/all_entries/widgets/widgets.dart';
import 'package:ml_app/app/bloc/app_bloc.dart';
import 'package:ml_app/edit_entry/edit_entry.dart';
import 'package:ml_app/todays_review/todays_review.dart';

class TodaysReviewPage extends StatelessWidget {
  const TodaysReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodaysReviewBloc(
        entriesRepository: context.read<EntriesRepository>(),
      )..add(const TodaysReviewSubscriptionRequested()),
      child: TodaysReviewPageView(),
    );
  }
}

class TodaysReviewPageView extends StatelessWidget {
  TodaysReviewPageView({Key? key}) : super(key: key);

  final Tween<double> _tween = Tween<double>(begin: 0, end: 1);

  @override
  Widget build(BuildContext context) {
    final dummy =
        DummData(entriesRepository: context.read<EntriesRepository>());
    late OverlayEntry _popupDialog;

    return Scaffold(
      body: BlocBuilder<TodaysReviewBloc, TodaysReviewState>(
        builder: (context, state) {
          if (state.filteredEntries.isEmpty) {
            if (state.status == TodaysReviewStatus.loading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state.status != TodaysReviewStatus.success) {
              return const SizedBox();
            } else {
              return Center(
                child: Text(
                  'You have no learnings to review today. '
                  'Add enough to ensure you are improving every day!',
                  style: Theme.of(context).textTheme.caption,
                ),
              );
            }
          }
          return CupertinoScrollbar(
            child: ListView(
              primary: false,
              children: [
                AppBar(
                  leading: IconButton(
                    onPressed: () =>
                        context.read<AppBloc>().add(AppLogoutRequested()),
                    icon: const Icon(Icons.logout_outlined),
                  ),
                  title: const Text(
                    "Today's Review",
                  ),
                  actions: [
                    IconButton(
                      onPressed: dummy.uploadDummyData,
                      icon: const Icon(Icons.ac_unit_outlined),
                    )
                  ],
                ),
                for (final entry in state.filteredEntries)
                  TodaysReviewListTile(
                    entry: entry,
                    onTap: () {
                      Navigator.of(context).push(
                        EditEntryPage.route(initialEntry: entry),
                      );
                    },
                    onLongPressStart: (_) {
                      _popupDialog = _createPopupDialog(entry);
                      Overlay.of(context)!.insert(_popupDialog);
                      context
                          .read<TodaysReviewBloc>()
                          .add(const TodaysReviewFocusedLearningStart());
                    },
                    onLongPressEnd: (_) {
                      _popupDialog.remove();
                      context
                          .read<TodaysReviewBloc>()
                          .add(TodaysReviewFocusedLearningEnd(entry));
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  OverlayEntry _createPopupDialog(Entry entry) {
    return OverlayEntry(
      builder: (context) => FocusAndIsolate(entry, _tween),
    );
  }
}
