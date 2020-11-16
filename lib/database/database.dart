import 'dart:io';

import 'package:blood_pressure_tracker/models/ordering_option.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName('Entry')
class Entries extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get systolic => integer()();

  IntColumn get diastolic => integer()();

  IntColumn get pulse => integer()();

  DateTimeColumn get timestamp => dateTime()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Entries])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (OpeningDetails details) async {
          if (details.wasCreated) {
            /*var now = DateTime.now();

            await into(entries).insert(EntriesCompanion(
              systolic: Value(120),
              diastolic: Value(80),
              pulse: Value(70),
              timestamp: Value(
                  DateTime(now.year, now.month, now.day, now.hour, now.minute)),
            ));

            await into(entries).insert(EntriesCompanion(
              systolic: Value(122),
              diastolic: Value(82),
              pulse: Value(73),
              timestamp: Value(
                  DateTime(now.year, now.month, now.day, now.hour, now.minute)
                      .subtract(Duration(hours: 1))),
            ));

            await into(entries).insert(EntriesCompanion(
              systolic: Value(119),
              diastolic: Value(79),
              pulse: Value(68),
              timestamp: Value(
                  DateTime(now.year, now.month, now.day, now.hour, now.minute)
                      .subtract(Duration(hours: 1, minutes: 30))),
            ));*/
          }
        },
      );

  Future<int> addEntry(EntriesCompanion entry) => into(entries).insert(entry);

  Future<bool> updateEntry(EntriesCompanion entry) =>
      update(entries).replace(entry);

  Future<int> deleteEntry(Entry entry) => delete(entries).delete(entry);

  Future<List<Entry>> get allEntries => (select(entries)
        ..orderBy([
          (entry) => OrderingTerm(expression: entry.timestamp),
        ]))
      .get();

  Stream<List<Entry>> watchAllEntries(Order order) {
    var orderingMode =
        (order == Order.descending) ? OrderingMode.desc : OrderingMode.asc;

    return (select(entries)
          ..orderBy([
            (entry) =>
                OrderingTerm(expression: entry.timestamp, mode: orderingMode),
          ]))
        .watch();
  }

  Stream<List<Entry>> watchAllEntriesInDay(DateTime date, Order order) {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0).toUtc();
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59).toUtc();

    var orderingMode =
        (order == Order.descending) ? OrderingMode.desc : OrderingMode.asc;

    return (select(entries)
          ..where((e) =>
              e.timestamp.isBiggerOrEqualValue(startOfDay) &
              e.timestamp.isSmallerOrEqualValue(endOfDay))
          ..orderBy([
            (entry) =>
                OrderingTerm(expression: entry.timestamp, mode: orderingMode),
          ]))
        .watch();
  }

  Stream<List<Entry>> watchEntriesInTimeInterval(
      DateTime start, DateTime end, Order order) {
    final beginning =
        DateTime(start.year, start.month, start.day, 0, 0).toUtc();
    final ending = DateTime(end.year, end.month, end.day, 23, 59).toUtc();

    var orderingMode =
        (order == Order.descending) ? OrderingMode.desc : OrderingMode.asc;

    return (select(entries)
          ..where((e) =>
              e.timestamp.isBiggerOrEqualValue(beginning) &
              e.timestamp.isSmallerOrEqualValue(ending))
          ..orderBy([
            (entry) =>
                OrderingTerm(expression: entry.timestamp, mode: orderingMode),
          ]))
        .watch();
  }

  Future<Entry> getLastEntry() {
    return (select(entries)
          ..orderBy([
            (e) =>
                OrderingTerm(expression: e.timestamp, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingle();
  }

  Stream<Entry> watchLastEntry() {
    return (select(entries)
          ..orderBy([
            (e) =>
                OrderingTerm(expression: e.timestamp, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .watchSingle();
  }

}