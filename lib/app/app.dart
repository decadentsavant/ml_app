import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/l10n/l10n.dart';
import 'package:ml_app/router/app_state.dart';
import 'package:ml_app/router/back_dispatcher.dart';
import 'package:ml_app/router/route_parser.dart';
import 'package:ml_app/router/router_delegate.dart';
import 'package:ml_app/router/ui_pages.dart';
import 'package:ml_app/theme/theme.dart';
import 'package:provider/provider.dart';

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
class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  _AppViewState() {
    delegate = MLRouterDelegate(appState);
    delegate.setNewRoutePath(splashPageConfig);
    backButtonDispatcher = MLBackButtonDispatcher(delegate);
  }

  final appState = AppState();
  late MLRouterDelegate delegate;
  final parser = MLParser();
  late MLBackButtonDispatcher backButtonDispatcher;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: MaterialApp.router(
        title: 'Most Learned App',
        theme: MostLearnedTheme.light,
        darkTheme: MostLearnedTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        backButtonDispatcher: backButtonDispatcher,
        routerDelegate: delegate,
        routeInformationParser: parser,
      ),
    );
  }
}
