import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/shared_ui_widgets/background.dart';

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
      body: Stack(
        children: [
          const Background(),
          Column(
            children: [
              ListTile(
                key: const Key('statsView_totalEntries_listTile'),
                leading: const Icon(Icons.leaderboard_outlined),
                title: const Text('Total Entries'),
                trailing: Text(
                  '${state.totalEntries}',
                  style: textTheme.headline5,
                ),
              ),
              ListTile(
                key: const Key('statsView_activeEntries_listTile'),
                leading: const Icon(Icons.animation_outlined),
                title: const Text('Active Entries'),
                trailing: Text(
                  '${state.activeEntries}',
                  style: textTheme.headline5,
                ),
              ),
              ListTile(
                key: const Key('statsView_archivedEntries_listTile'),
                leading: const Icon(Icons.dialpad_outlined),
                title: const Text('Archived Entries'),
                trailing: Text(
                  '${state.archivedEntries}',
                  style: textTheme.headline5,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
