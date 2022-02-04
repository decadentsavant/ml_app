import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/theme/shared_ui_widgets/shared_ui_widgets.dart';
import 'package:ml_app/todays_review/bloc/todays_review_bloc.dart';

class TodaysReviewPage extends StatelessWidget {
  const TodaysReviewPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => TodaysReviewBloc(
            // entriesrepository: EntriesRepository,
            ),
        child: const TodaysReviewPage(),
      ),
    );
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          Background(),
          Center(
            child: Text('Todays Review Page'),
          )
        ],
      ),
    );
  }
}
