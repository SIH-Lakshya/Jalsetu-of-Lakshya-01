import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get role => text()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Watersheds extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get code => text()();
  TextColumn get description => text()();
  RealColumn get centerLat => real()();
  RealColumn get centerLng => real()();
  RealColumn get areaKm2 => real()();
  TextColumn get state => text()();
  TextColumn get district => text()();
  TextColumn get programIds => text().map(const StringListConverter())();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class WatershedBoundaries extends Table {
  TextColumn get watershedId => text()();
  TextColumn get coordinates => text().map(const LatLngListConverter())();
  TextColumn get geometryType => text()();

  @override
  Set<Column> get primaryKey => {watershedId};
}

class Observations extends Table {
  TextColumn get id => text()();
  TextColumn get watershedId => text()();
  TextColumn get userId => text()();
  TextColumn get type => text()();
  TextColumn get status => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get gpsAccuracy => real()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get notes => text().nullable()();
  TextColumn get photoIds => text().map(const StringListConverter())();
  TextColumn get interventionId => text().nullable()();
  TextColumn get metadata => text().map(const JsonMapConverter())();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Interventions extends Table {
  TextColumn get id => text()();
  TextColumn get watershedId => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get status => text()();
  TextColumn get description => text()();
  DateTimeColumn get plannedDate => dateTime()();
  DateTimeColumn get actualDate => dateTime().nullable()();
  RealColumn get estimatedCost => real()();
  RealColumn get actualCost => real().nullable()();
  TextColumn get contractor => text().nullable()();
  TextColumn get photoIds => text().map(const StringListConverter())();
  TextColumn get metadata => text().map(const JsonMapConverter())();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Photos extends Table {
  TextColumn get id => text()();
  TextColumn get observationId => text()();
  TextColumn get localPath => text()();
  TextColumn get remoteUrl => text().nullable()();
  IntColumn get width => integer()();
  IntColumn get height => integer()();
  IntColumn get fileSize => integer()();
  TextColumn get mimeType => text()();
  DateTimeColumn get capturedAt => dateTime()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  RealColumn get altitude => real().nullable()();
  RealColumn get gpsAccuracy => real().nullable()();
  TextColumn get deviceId => text().nullable()();
  TextColumn get exifData => text().map(const JsonMapConverter())();
  TextColumn get status => text()();
  DateTimeColumn get uploadedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation => text()();
  TextColumn get payload => text().map(const JsonMapConverter())();
  IntColumn get retryCount => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  TextColumn get errorMessage => text().nullable()();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return fromDb.split(',').where((s) => s.isNotEmpty).toList();
  }

  @override
  String toSql(List<String> value) => value.join(',');
}

class LatLngListConverter extends TypeConverter<List<LatLng>, String> {
  const LatLngListConverter();

  @override
  List<LatLng> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    final parts = fromDb.split(';');
    return parts.map((p) {
      final coords = p.split(',');
      return LatLng(double.parse(coords[0]), double.parse(coords[1]));
    }).toList();
  }

  @override
  String toSql(List<LatLng> value) =>
      value.map((ll) => '${ll.latitude},${ll.longitude}').join(';');
}

class JsonMapConverter extends TypeConverter<Map<String, dynamic>, String> {
  const JsonMapConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) {
    if (fromDb.isEmpty) return {};
    return Map<String, dynamic>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(Map<String, dynamic> value) => jsonEncode(value);
}

@DriftDatabase(tables: [
  Users,
  Watersheds,
  WatershedBoundaries,
  Observations,
  Interventions,
  Photos,
  SyncQueue,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'jalsetu.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}