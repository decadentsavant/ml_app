import 'package:entries_repository/entries_repository.dart';
import 'package:intl/intl.dart';

List<Entry> createTodaysReviewList({required List<Entry> entries}) {
  if (entries.isEmpty) return [];

  final timeStamp = DateTime.now();
  final activeDailies = <Entry>[];
  final activePeriodicals = <Entry>[];
  final results = <Entry>[];

  for (final entry in entries) {
    // Filter out inactive entries...
    if (entry.isActive == false) {
      break;
    }

    // ...if active, split up dailies and periodicals...
    else {
      if (entry.frequencyType == FrequencyType.daily) {
        activeDailies.add(entry);
      } else {
        activePeriodicals.add(entry);
      }
    }
  }

  // ...only add dailies to final list if today's date + frequencyInDays[last]
  //  is before today...
  for (final entry in activeDailies) {
    final expirationDate =
        entry.activationDate.add(Duration(days: entry.frequencyInDays.last));
    final lastSecondOfThatDay = DateTime(
      expirationDate.year,
      expirationDate.month,
      expirationDate.day,
      23,
      59,
      59,
      999,
    );
    if (timeStamp.isBefore(lastSecondOfThatDay)) {
      results.add(entry);
    }
  }

  // ...only add periodicals to final list if today's date + any of the integers
  // in freqeuncyInDays is today...
  for (final entry in activePeriodicals) {
    if (entry.frequencyInDays
        .map(
          (e) => DateFormat.yMMMd()
              .format(entry.activationDate.toLocal().add(Duration(days: e))),
        )
        .toList()
        .contains(DateFormat.yMMMd().format(timeStamp))) {
      results.add(entry);
    }
  }

  // ...sort by EntryPriority.
  results.sort(
    (a, b) => b.entryPriority.index.compareTo(a.entryPriority.index),
  );

  return results;
}
