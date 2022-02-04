import 'package:flutter/material.dart';
import 'package:ml_app/theme/shared_ui_widgets/shared_ui_widgets.dart';

class NewEntryPage extends StatelessWidget {
  const NewEntryPage({Key? key}) : super(key: key);

  static Route<void> route(/*Entry? initialEntry}*/) {
    return MaterialPageRoute(
      builder: (context) => const NewEntryPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Entry Page'),
      ),
      body: Stack(
        children: const [
          Background(),
          Center(
            child: Text('New Entry Page'),
          )
        ],
      ),
    );
  }
}
