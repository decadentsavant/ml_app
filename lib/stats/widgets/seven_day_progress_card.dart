import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/app_theme.dart';

class SevenDayProgressCard extends StatelessWidget {
  const SevenDayProgressCard({
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
              const Text('Your weekly progress'),
              const Text('Last 7 days'),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${state.didMakeEntryAndMeetFocusGoalEachOfLast7Days.length}/7',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Text('Achieved'),
                    ],
                  ),
                  Row(
                    children: groupedValues.map((data) {
                      return IndividualDayTracking(
                        dayAbbreviation: data['abbreviation'] as String,
                        didMakeEntry: data['entryMade'] as bool,
                        focusProgress: data['focusProgress'] as int,
                        didMakeEntryAndMeetFocusGoal: data[
                            'didMakeEntryAndMeetFocusGoal'
                          ] as bool,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get groupedValues {
    return List.generate(
      7,
      (index) {
        final dayOfWeek = DateTime.now().subtract(
          Duration(days: index),
        );
        
        return {
          'abbreviation': DateFormat.E().format(dayOfWeek).substring(0, 1),
          'entryMade': state.didMakeEntryLast7Days[index] ?? false,
          'focusProgress': state.totalFocusedSecondsEachOfLast7Days[index] ?? 0,
          'didMakeEntryAndMeetFocusGoal':
              state.didMakeEntryAndMeetFocusGoalEachOfLast7Days[index] ?? false,
        };
      },
    ).reversed.toList();
  }
}
