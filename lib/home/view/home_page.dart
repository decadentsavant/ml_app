import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/home/Widgets/widgets.dart';
import 'package:ml_app/home/home.dart';

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
      extendBody: true,
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          NewEntryPage(),
          TodaysReviewPage(),
          AllEntriesPage(),
          AccountPage(),
          StatsPage(),
        ],
      ),
    bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
