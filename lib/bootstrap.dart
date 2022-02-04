import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:entries_api/entries_api.dart';
import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:ml_app/app/app.dart';
import 'package:ml_app/app/app_bloc_observer.dart';

//entriesApi is abstract. LocalStorageEntriesApi is an implementation
//of an entriesApi instance and is valid
void bootstrap({required EntriesApi entriesApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // The EntriesRepository needs an apit to talk to. It accepts teh 
  // LocalStorage EntriesApi here
  final entriesRepository = EntriesRepository(entriesApi: entriesApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          // The app interfaces with this repo instead of data layers
          App(entriesRepository: entriesRepository),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
