import 'package:flutter/material.dart';
import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/theme.dart';

class EntriesCount extends StatelessWidget {
  const EntriesCount({
    Key? key,
    required this.state,
    required this.textTheme,
  }) : super(key: key);

  final StatsState state;
  final TextTheme textTheme;

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
            children: [
              const Text('Your entries'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${state.totalEntries}',
                          style: textTheme.headline5,
                        ),
                        const Text(
                          'Total',
                          style: TextStyle(color: MLColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${state.totalActiveEntries}',
                          style: textTheme.headline5,
                        ),
                        const Text(
                          'Active',
                          style: TextStyle(color: MLColors.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${state.totalArchivedEntries}',
                          style: textTheme.headline5,
                        ),
                        const Text(
                          'Archived',
                          style: TextStyle(color: MLColors.errorColor),
                        ),
                      ],
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
