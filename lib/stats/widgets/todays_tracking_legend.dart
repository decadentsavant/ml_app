import 'package:flutter/material.dart';
import 'package:ml_app/theme/theme.dart';

class TodaysTrackingLegend extends StatelessWidget {
  const TodaysTrackingLegend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.schedule_outlined,
          color: MLColors.primaryColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('Focused'),
            Text('time'),
          ],
        ),
        const SizedBox(width: 24),
        const Icon(
          Icons.tips_and_updates_outlined,
          color: MLColors.secondaryColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('Entries'),
            Text('made'),
          ],
        ),
      ],
    );
  }
}
