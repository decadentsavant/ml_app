import 'package:authentication_repository/authentication_repository.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/app/app.dart';
import 'package:ml_app/l10n/l10n.dart';
import 'package:ml_app/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required EntriesRepository entriesRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        _entriesRepository = entriesRepository,
        super(key: key);

  final EntriesRepository _entriesRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EntriesRepository>(
          create: (context) => _entriesRepository,
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => _authenticationRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterMLTheme.light,
      // darkTheme: FlutterMLTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
