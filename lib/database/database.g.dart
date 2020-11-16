// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Entry extends DataClass implements Insertable<Entry> {
  final int id;
  final int systolic;
  final int diastolic;
  final int pulse;
  final DateTime timestamp;

  Entry(
      {@required this.id,
      @required this.systolic,
      @required this.diastolic,
      @required this.pulse,
      @required this.timestamp});

  factory Entry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Entry(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      systolic:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}systolic']),
      diastolic:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}diastolic']),
      pulse: intType.mapFromDatabaseResponse(data['${effectivePrefix}pulse']),
      timestamp: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || systolic != null) {
      map['systolic'] = Variable<int>(systolic);
    }
    if (!nullToAbsent || diastolic != null) {
      map['diastolic'] = Variable<int>(diastolic);
    }
    if (!nullToAbsent || pulse != null) {
      map['pulse'] = Variable<int>(pulse);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<DateTime>(timestamp);
    }
    return map;
  }

  EntriesCompanion toCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      systolic: systolic == null && nullToAbsent
          ? const Value.absent()
          : Value(systolic),
      diastolic: diastolic == null && nullToAbsent
          ? const Value.absent()
          : Value(diastolic),
      pulse:
          pulse == null && nullToAbsent ? const Value.absent() : Value(pulse),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
    );
  }

  factory Entry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Entry(
      id: serializer.fromJson<int>(json['id']),
      systolic: serializer.fromJson<int>(json['systolic']),
      diastolic: serializer.fromJson<int>(json['diastolic']),
      pulse: serializer.fromJson<int>(json['pulse']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'systolic': serializer.toJson<int>(systolic),
      'diastolic': serializer.toJson<int>(diastolic),
      'pulse': serializer.toJson<int>(pulse),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  Entry copyWith(
          {int id,
          int systolic,
          int diastolic,
          int pulse,
          DateTime timestamp}) =>
      Entry(
        id: id ?? this.id,
        systolic: systolic ?? this.systolic,
        diastolic: diastolic ?? this.diastolic,
        pulse: pulse ?? this.pulse,
        timestamp: timestamp ?? this.timestamp,
      );

  @override
  String toString() {
    return (StringBuffer('Entry(')
          ..write('id: $id, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('pulse: $pulse, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          systolic.hashCode,
          $mrjc(
              diastolic.hashCode, $mrjc(pulse.hashCode, timestamp.hashCode)))));

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Entry &&
          other.id == this.id &&
          other.systolic == this.systolic &&
          other.diastolic == this.diastolic &&
          other.pulse == this.pulse &&
          other.timestamp == this.timestamp);
}

class EntriesCompanion extends UpdateCompanion<Entry> {
  final Value<int> id;
  final Value<int> systolic;
  final Value<int> diastolic;
  final Value<int> pulse;
  final Value<DateTime> timestamp;

  const EntriesCompanion({
    this.id = const Value.absent(),
    this.systolic = const Value.absent(),
    this.diastolic = const Value.absent(),
    this.pulse = const Value.absent(),
    this.timestamp = const Value.absent(),
  });

  EntriesCompanion.insert({
    this.id = const Value.absent(),
    @required int systolic,
    @required int diastolic,
    @required int pulse,
    @required DateTime timestamp,
  })  : systolic = Value(systolic),
        diastolic = Value(diastolic),
        pulse = Value(pulse),
        timestamp = Value(timestamp);

  static Insertable<Entry> custom({
    Expression<int> id,
    Expression<int> systolic,
    Expression<int> diastolic,
    Expression<int> pulse,
    Expression<DateTime> timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (pulse != null) 'pulse': pulse,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  EntriesCompanion copyWith(
      {Value<int> id,
      Value<int> systolic,
      Value<int> diastolic,
      Value<int> pulse,
      Value<DateTime> timestamp}) {
    return EntriesCompanion(
      id: id ?? this.id,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      pulse: pulse ?? this.pulse,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (systolic.present) {
      map['systolic'] = Variable<int>(systolic.value);
    }
    if (diastolic.present) {
      map['diastolic'] = Variable<int>(diastolic.value);
    }
    if (pulse.present) {
      map['pulse'] = Variable<int>(pulse.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesCompanion(')
          ..write('id: $id, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('pulse: $pulse, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $EntriesTable extends Entries with TableInfo<$EntriesTable, Entry> {
  final GeneratedDatabase _db;
  final String _alias;

  $EntriesTable(this._db, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;

  @override
  GeneratedIntColumn get id => _id ??= _constructId();

  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _systolicMeta = const VerificationMeta('systolic');
  GeneratedIntColumn _systolic;

  @override
  GeneratedIntColumn get systolic => _systolic ??= _constructSystolic();

  GeneratedIntColumn _constructSystolic() {
    return GeneratedIntColumn(
      'systolic',
      $tableName,
      false,
    );
  }

  final VerificationMeta _diastolicMeta = const VerificationMeta('diastolic');
  GeneratedIntColumn _diastolic;

  @override
  GeneratedIntColumn get diastolic => _diastolic ??= _constructDiastolic();

  GeneratedIntColumn _constructDiastolic() {
    return GeneratedIntColumn(
      'diastolic',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pulseMeta = const VerificationMeta('pulse');
  GeneratedIntColumn _pulse;

  @override
  GeneratedIntColumn get pulse => _pulse ??= _constructPulse();

  GeneratedIntColumn _constructPulse() {
    return GeneratedIntColumn(
      'pulse',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedDateTimeColumn _timestamp;

  @override
  GeneratedDateTimeColumn get timestamp => _timestamp ??= _constructTimestamp();

  GeneratedDateTimeColumn _constructTimestamp() {
    return GeneratedDateTimeColumn(
      'timestamp',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, systolic, diastolic, pulse, timestamp];

  @override
  $EntriesTable get asDslTable => this;

  @override
  String get $tableName => _alias ?? 'entries';
  @override
  final String actualTableName = 'entries';

  @override
  VerificationContext validateIntegrity(Insertable<Entry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('systolic')) {
      context.handle(_systolicMeta,
          systolic.isAcceptableOrUnknown(data['systolic'], _systolicMeta));
    } else if (isInserting) {
      context.missing(_systolicMeta);
    }
    if (data.containsKey('diastolic')) {
      context.handle(_diastolicMeta,
          diastolic.isAcceptableOrUnknown(data['diastolic'], _diastolicMeta));
    } else if (isInserting) {
      context.missing(_diastolicMeta);
    }
    if (data.containsKey('pulse')) {
      context.handle(
          _pulseMeta, pulse.isAcceptableOrUnknown(data['pulse'], _pulseMeta));
    } else if (isInserting) {
      context.missing(_pulseMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Entry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Entry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EntriesTable createAlias(String alias) {
    return $EntriesTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EntriesTable _entries;

  $EntriesTable get entries => _entries ??= $EntriesTable(this);

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [entries];
}
