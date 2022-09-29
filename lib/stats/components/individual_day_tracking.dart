import 'package:flutter/material.dart';
import 'package:ml_app/stats/stats.dart';

class IndividualDayTracking extends StatelessWidget {
  const IndividualDayTracking({
    required this.dayAbbreviation,
    required this.didMakeEntry,
    required this.focusProgress,
    required this.didMakeEntryAndMeetFocusGoal,
    super.key,
  });

  final String dayAbbreviation;
  final bool didMakeEntry;
  final int focusProgress;
  final bool didMakeEntryAndMeetFocusGoal;
  static const double padding = 6;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: padding),
            child: Icon(
              Icons.check,
              size: 12,
              color: didMakeEntryAndMeetFocusGoal
                  ? Colors.black
                  : Colors.transparent,
            ),
          ),
          CustomPaint(
            foregroundPainter: ProgressCircle(
              currentProgress: focusProgress,
              radius: 10,
              strokeCircle: 2,
            ),
            child: SizedBox(
              width: 18,
              height: 18,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (didMakeEntry)
                      const Icon(Icons.lightbulb_outlined, size: 12),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: padding),
            child: Text(dayAbbreviation),
          ),
        ],
      ),
    );
  }
}
