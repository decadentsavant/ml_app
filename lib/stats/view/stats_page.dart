import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/stats/stats.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsBloc(
        entriesRepository: context.read<EntriesRepository>(),
      )..add(const StatsSubscriptionRequested()),
      child: const StatsView(),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StatsBloc>().state;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              title: const Text('Your Statistics'),
              centerTitle: true,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Center(child: Text("Today's Progress")),
            ),
            const TodaysTrackingLegend(),
            const SizedBox(height: 5),
            TodaysTrackingChart(
              totalFocusedSecondsToday: state.totalFocusedSecondsToday,
              totalEntriesMadeToday: state.totalEntriesMadeToday,
            ),
            SevenDayProgressCard(state: state),
            const SizedBox(
              height: 5,
            ),
            WeeklyTargetCard(
              state: state,
            ),
            const SizedBox(
              height: 5,
            ),
            EntriesCount(state: state, textTheme: textTheme),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
