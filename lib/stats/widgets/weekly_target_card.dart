import 'package:flutter/material.dart';
import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/app_theme.dart';

class WeeklyTargetCard extends StatelessWidget {
  const WeeklyTargetCard({
    required this.state,
    super.key,
  });

  final StatsState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MLPadding.defaultWidget,
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Your weekly target - 21 minutes'),
              Text(DateUtility.formatTheCurrentWeek()),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                    // ignore: lines_longer_than_80_chars
                      '${DateUtility.formatSecondsToMinutesAndSeconds(state.totalFocusedSecondsThisWeek)} of 21',
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomPaint(
                      foregroundPainter: ProgressLine(
                        currentProgress: 33,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
