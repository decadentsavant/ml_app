import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/stats/components/hero_tracking_widget.dart';
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
          children: [
            AppBar(
              title: const Text('Stats Page'),
            ),
            const SizedBox(
              height: 8,
            ),

// Hero Widget...Today's Progress
            CustomPaint(
              foregroundPainter: CircleProgress(),
              child: Container(
                width: 300,
                height: 300,
                color: Colors.blue,
                child: const Center(
                  child: Icon(Icons.lightbulb_outline_rounded)
                ),
              ),
            ),

// 7 Day Progress Indicators
            ListTile(
              key: const Key('statsView_didMakeEntryLastSevenDays_listTile'),
              leading: const Icon(Icons.qr_code_2_outlined),
              title: const Text('didMakeEntryLastSevenDays: '),
              trailing: Text(
                '${state.didMakeEntryLastSevenDays}',
                style: textTheme.headline5,
              ),
            ),
            ListTile(
              key: const Key('statsView_didFocusLastSevenDays_listTile'),
              leading: const Icon(Icons.qr_code_2_outlined),
              title: const Text('didFocusLastSevenDays: '),
              trailing: Text(
                '${state.didFocusLastSevenDays}',
                style: textTheme.headline5,
              ),
            ),
            ListTile(
              key: const Key('statsView_focusedSecondsLastSevenDays_listTile'),
              leading: const Icon(Icons.qr_code_2_outlined),
              title: const Text('focusedSecondsLastSevenDays: '),
              trailing: Text(
                '${state.focusedSecondsLastSevenDays}',
                style: textTheme.headline5,
              ),
            ),
// Entries Counts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      '${state.allEntries}',
                      style: textTheme.headline5,
                    ),
                    const Text('Entries'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '${state.activeEntries}',
                      style: textTheme.headline5,
                    ),
                    const Text('Active'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '${state.archivedEntries}',
                      style: textTheme.headline5,
                    ),
                    const Text('Archived'),
                  ],
                ),
              ],
            ),
// Accumulation of Focus
            ListTile(
              title: const Text('Total Focus Time in Seconds: '),
              trailing: Text(
                '${state.totalFocusTimeInSeconds}',
                style: textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
