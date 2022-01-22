import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.entriesRepository}) : super(key: key);

  final EntriesRepository entriesRepository;

  @override
  Widget build(BuildContext context) {
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
    return const MaterialApp(
      home: Center(
        child: Text('FUCK YAH'),
      ),
    );
  }
}
