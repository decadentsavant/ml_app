import 'package:entries_repository/entries_repository.dart';

class DummData {
  DummData({
    required EntriesRepository entriesRepository,
  })  : _entriesRepository = entriesRepository;
  
  final EntriesRepository _entriesRepository;

  Future<void> uploadDummyData() async {
      for (final element in _dummyData) {
      await _entriesRepository.saveEntry(element);   
    }
  }

  final List<Entry> _dummyData = [
  Entry(
    title: 'periodically normal even 987',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    // frequencyType: FrequencyType.periodically,
    frequencyInDays: const [2,4,6,8,10,12,14,16,18,20],
    // entryPriority: EntryPriority.normal,
    activationDate: DateTime.utc(2022, 3, 20),
    // isActive: true,
  ),
  Entry(
    title: 'periodically high even 678',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    // frequencyType: FrequencyType.periodically,
    frequencyInDays: const [2,4,6,8,10,12,14,16,18,20],
    entryPriority: EntryPriority.high,
    activationDate: DateTime.utc(2022, 3, 21),
    // isActive: true,
  ),
  Entry(
    title: 'periodically normal odd 456',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    // frequencyType: FrequencyType.periodically,
    frequencyInDays: const [1,3,5,7,9,11,13,15,17,19,21],
    // entryPriority: EntryPriority.normal,
    activationDate: DateTime.utc(2022, 3, 20),
    // isActive: true,
  ),
  Entry(
    title: 'periodically high odd 123',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    // frequencyType: FrequencyType.periodically,
    frequencyInDays: const [1,3,5,7,9,11,13,15,17,19,21],
    entryPriority: EntryPriority.high,
    activationDate: DateTime.utc(2022, 3, 21),
    // isActive: true,
  ),
  Entry(
    title: 'periodically highest odd 123',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    // frequencyType: FrequencyType.periodically,
    frequencyInDays: const [1,3,5,7,9,11,13,15,17,19,21],
    entryPriority: EntryPriority.highest,
    activationDate: DateTime.utc(2022, 3, 3),
    // isActive: true,
  ),
  Entry(
    title: 'periodically normal 3s 123',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    // frequencyType: FrequencyType.periodically,
    frequencyInDays: const [3,6,9,12,15,18,21,24],
    // entryPriority: EntryPriority.normal,
    activationDate: DateTime.utc(2022, 3, 7),
    // isActive: true,
  ),
  Entry(
    title: 'high 2022 365 daily',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    frequencyType: FrequencyType.daily,
    frequencyInDays: const [365],
    entryPriority: EntryPriority.high,
    activationDate: DateTime.utc(2021, 10, 28),
    // isActive: true,
  ),
  Entry(
    title: 'normal 20201 365 daily ',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    frequencyType: FrequencyType.daily,
    frequencyInDays: const [365],
    // entryPriority: EntryPriority.normal,
    activationDate: DateTime.utc(2021, 10, 28),
    // isActive: true,
  ),
  Entry(
    title: 'highest 2022 365 daily',
    source: 'source test',
    notes: 'notes test',
    relatedUrl: 'google.com',
    frequencyType: FrequencyType.daily,
    frequencyInDays: const [365],
    entryPriority: EntryPriority.highest,
    activationDate: DateTime.utc(2021, 10, 29),
    // isActive: true,
  ),
  Entry(
    title: 'Too old to show',
    source: 'source test',
    notes: '1978 365 daily',
    relatedUrl: 'google.com',
    frequencyType: FrequencyType.daily,
    frequencyInDays: const [365],
    // entryPriority: EntryPriority.normal,
    activationDate: DateTime.utc(1978, 08, 18),
    // isActive: true,
  ),
  Entry(
    title: 'Is Not Active',
    source: 'source test',
    notes: '1978 365 daily',
    relatedUrl: 'google.com',
    frequencyType: FrequencyType.daily,
    frequencyInDays: const [365],
    // entryPriority: EntryPriority.normal,
    activationDate: DateTime.utc(2022, 01, 02),
    isActive: false,
  ),
];
}
