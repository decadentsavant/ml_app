import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/account/account.dart.dart';
import 'package:ml_app/all_entries/all_entries.dart';
import 'package:ml_app/home/main_view.dart';
import 'package:ml_app/new_entry/new_entry.dart';
import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/todays_review/todays_review.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          TodaysReviewPage(),
          AllEntriesPage(),
          StatsPage(),
          AccountPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        key: const Key('homeView_addEntry_floatingActionButtion'),
        onPressed: () => Navigator.of(context).push(NewEntryPage.route()),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.today,
              icon: const Icon(Icons.access_time_outlined),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.all,
              icon: const Icon(Icons.list_alt_outlined),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.stats,
              icon: const Icon(Icons.bar_chart_outlined),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.account,
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
