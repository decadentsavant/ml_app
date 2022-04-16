import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:entries_api/entries_api.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:ml_app/app/app.dart';

//entriesApi is abstract. LocalStorageEntriesApi is an implementation
//of an entriesApi instance and is valid
void bootstrap({required EntriesApi entriesApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // The EntriesRepository needs an api to talk to. It accepts the
  // LocalStorage EntriesApi here
  final entriesRepository = EntriesRepository(entriesApi: entriesApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async {
          final authenticationRepository = AuthenticationRepository();
          await authenticationRepository.user.first;
          runApp(
            App(
              entriesRepository: entriesRepository,
              authenticationRepository: authenticationRepository,
            ),
          );
        },
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
