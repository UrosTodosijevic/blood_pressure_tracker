import 'package:blood_pressure_tracker/database/database.dart';
import 'package:blood_pressure_tracker/models/models.dart';
import 'package:blood_pressure_tracker/utils/date_time_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Database provider
final databaseProvider = Provider<Database>((ref) {
  var database = Database();
  ref.onDispose(() => database.close());
  return database;
});

/// Provides a stream which emits latest database entry by timestamp
final lastEntryStreamProvider = StreamProvider<Entry>((ref) {
  var database = ref.watch(databaseProvider);
  return database.watchLastEntry();
});

/// Provides currently selected ordering option.
final orderingProvider = StateProvider<Order>((ref) => Order.descending);

/// Provides currently selected time period for showing entries
final timeIntervalProvider = StateProvider((ref) => TimeInterval.today);

/// Provides Stream of List<Entry> based on values of ordering option and time period
// ignore: missing_return
final listOfEntriesProvider = StreamProvider<List<Entry>>((ref) {
  var database = ref.watch(databaseProvider);
  var timePeriod = ref.watch(timeIntervalProvider).state;
  var order = ref.watch(orderingProvider).state;

  var now = currentDateTime();

  switch (timePeriod) {
    case TimeInterval.today:
      return database.watchAllEntriesInDay(now, order);
    case TimeInterval.yesterday:
      return database.watchAllEntriesInDay(
          now.subtract(Duration(days: 1)), order);
    case TimeInterval.week:
      return database.watchEntriesInTimeInterval(
          firstDayOfTheWeek(now), lastDayOfTheWeek(now), order);
    case TimeInterval.month:
      return database.watchEntriesInTimeInterval(
          firstDayOfTheMonth(now), lastDayOfTheMonth(now), order);
    case TimeInterval.forever:
      return database.watchAllEntries(order);
  }
});

/// Provides Hive's [Box] throughout the application
final boxProvider = Provider<Box<dynamic>>((ref) {
  var box = Hive.box('changes');
  if (!box.containsKey('has_changes')) {
    box.put('has_changes', false);
  }
  ref.onDispose(() async {
    await box.compact();
    await box.close();
  });
  return box;
});

/// Provides ValueListenable<Box<dynamic>> so that we could use it
/// in [ValueListenableBuilder] and react on changes in box.
final listenableProvider = Provider<ValueListenable<Box>>((ref) {
  var box = ref.watch(boxProvider);
  return box.listenable(keys: ['has_changes']);
});
