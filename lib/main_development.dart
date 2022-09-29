import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_entries_api/firebase_entries_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:ml_app/app/app_bloc_observer.dart';
import 'package:ml_app/bootstrap.dart';
import 'package:ml_app/firebase_options.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firestoreInstance = FirebaseFirestore.instance;

  bootstrap(entriesApi: FirebaseEntriesApi(firestoreInstance));
}
