import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/all_entries/all_entries.dart';
import 'package:ml_app/edit_entry/edit_entry.dart';
import 'package:ml_app/home/home.dart';
import 'package:ml_app/profile/profile.dart';
import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/theme.dart';
import 'package:ml_app/todays_review/view/todays_review_dart.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

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

    return ScaffoldWrapper(
      scaffold: Scaffold(
        body: IndexedStack(
          index: selectedTab.index,
          children: const [
            TodaysReviewPage(),
            AllEntriesPage(),
            StatsPage(),
            ProfilePage(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          key: const Key('homeView_addEntry_floatingActionButton'),
          onPressed: () => Navigator.of(context).push(EditEntryPage.route()),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.todaysReview,
                icon: const Icon(Icons.tips_and_updates_outlined),
              ),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.allEntries,
                icon: const Icon(Icons.list_rounded),
              ),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.stats,
                icon: const Icon(Icons.insights_outlined),
              ),
              _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.profile,
                icon: const Icon(Icons.person),
              ),
            ],
          ),
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
      // color: groupValue != value
      //     ? Theme.of(context).colorScheme.secondary
      //     : Theme.of(context).colorScheme.primary,
      icon: icon,
    );
  }
}
