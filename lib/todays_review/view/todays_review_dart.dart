import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: const TodaysReviewPageView(),
    );
  }
}

class TodaysReviewPageView extends StatelessWidget {
  const TodaysReviewPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dummy =
        DummData(entriesRepository: context.read<EntriesRepository>());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
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
                for (final entry in state.filteredEntries)
                  TodaysReviewListTile(
                    entry: entry,
                    onTap: () {
                      Navigator.of(context).push(
                        EditEntryPage.route(initialEntry: entry),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
