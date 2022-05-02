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
      appBar: AppBar(
        title: const Text('Stats Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              key: const Key('statsView_completedEntries_listTile'),
              leading: const Icon(Icons.check_rounded),
              title: const Text('All Entries Count: '),
              trailing: Text(
                '${state.allEntries}',
                style: textTheme.headline5,
              ),
            ),
            ListTile(
              key: const Key('statsView_activeEntries_listTile'),
              leading: const Icon(Icons.run_circle_outlined),
              title: const Text('Active Entries Count: '),
              trailing: Text(
                '${state.activeEntries}',
                style: textTheme.headline5,
              ),
            ),
            ListTile(
              key: const Key('statsView_archivedEntries_listTile'),
              leading: const Icon(Icons.warning_amber_outlined),
              title: const Text('Archived Entries Count: '),
              trailing: Text(
                '${state.archivedEntries}',
                style: textTheme.headline5,
              ),
            ),
            ListTile(
              key: const Key('statsView_totalFocusTimeInSeconds_listTile'),
              leading: const Icon(Icons.padding_outlined),
              title: const Text('Total Focus Time in Seconds: '),
              trailing: Text(
                '${state.totalFocusTimeInSeconds}',
                style: textTheme.headline5,
              ),
            ),
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
              key: const Key('statsView_focusedSecondsLastSevenDays_listTile'),
              leading: const Icon(Icons.qr_code_2_outlined),
              title: const Text('focusedSecondsLastSevenDays: '),
              trailing: Text(
                '${state.focusedSecondsLastSevenDays}',
                style: textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
