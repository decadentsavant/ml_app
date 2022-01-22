import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:entries_api/entries_api.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:ml_app/app/app.dart';
import 'package:ml_app/app/app_bloc_observer.dart';

void bootstrap({required EntriesApi entriesApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final entriesRepository = EntriesRepository(entriesApi: entriesApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          App(entriesRepository: entriesRepository),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
