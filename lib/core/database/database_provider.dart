import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_database.dart';
import 'daos.dart';
import 'database_seeder.dart';

part 'database_provider.g.dart';

@riverpod
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  DatabaseSeeder.seedIfEmpty(db);
  ref.onDispose(() => db.close());
  return db;
}

final watershedDaoProvider = Provider<WatershedDao>((ref) {
  return WatershedDao(ref.watch(appDatabaseProvider));
});

final observationDaoProvider = Provider<ObservationDao>((ref) {
  return ObservationDao(ref.watch(appDatabaseProvider));
});

final interventionDaoProvider = Provider<InterventionDao>((ref) {
  return InterventionDao(ref.watch(appDatabaseProvider));
});

final photoDaoProvider = Provider<PhotoDao>((ref) {
  return PhotoDao(ref.watch(appDatabaseProvider));
});

final syncQueueDaoProvider = Provider<SyncQueueDao>((ref) {
  return SyncQueueDao(ref.watch(appDatabaseProvider));
});