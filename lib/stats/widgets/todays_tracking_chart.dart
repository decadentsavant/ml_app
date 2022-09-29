import 'package:flutter/material.dart';
import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/theme.dart';

class TodaysTrackingChart extends StatelessWidget {
  const TodaysTrackingChart({
    Key? key,
    required this.totalFocusedSecondsToday,
    required this.totalEntriesMadeToday,
  }) : super(key: key);

  final int totalFocusedSecondsToday;
  final int totalEntriesMadeToday;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: ProgressCircle(
        currentProgress: totalFocusedSecondsToday,
        radius: 75,
        strokeCircle: 8,
      ),
      child: SizedBox(
        width: 200,
        height: 200,
        child: Center(
          child: Stack(
            children: <Widget>[
              Align(
                child: Text(
                  DateUtility.formatSecondsToMinutesAndSeconds(
                    totalFocusedSecondsToday,
                  ),
                  style: const TextStyle(
                    fontSize: 30,
                    color: MLColors.primaryShadeDark1,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, .5),
                child: Text(
                  totalEntriesMadeToday.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                    color: MLColors.secondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
