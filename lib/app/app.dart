import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/home/view/home_page.dart';
import 'package:ml_app/l10n/l10n.dart';
import 'package:ml_app/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.entriesRepository}) : super(key: key);

  final EntriesRepository entriesRepository;

  @override
  Widget build(BuildContext context) {
    // This is the dependency injection of the repo for the rest of the app
    return RepositoryProvider.value(
      value: entriesRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Most Learned App',
      theme: MostLearnedTheme.light,
      darkTheme: MostLearnedTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
