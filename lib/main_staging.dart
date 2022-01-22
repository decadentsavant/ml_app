import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:local_storage_entries_api/local_storage_entries_api.dart';
import 'package:ml_app/bootstrap.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();

  final entriesApi = LocalStorageEntriesApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(entriesApi: entriesApi);
}
