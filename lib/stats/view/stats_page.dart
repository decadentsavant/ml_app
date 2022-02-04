import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/shared_ui_widgets/background.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => StatsBloc(
            // entriesrepository: EntriesRepository,
            ),
        child: const StatsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 100,
              ),
              child: Center(
                child: Text('Stats Page'),
              ),
            )
          ],
        )
      ],
    );
  }
}
