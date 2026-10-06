import 'package:drift/drift.dart';
import 'app_database.dart';

part 'daos.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<void> insertUser(UsersCompanion user) => into(users).insert(user);
  Future<void> updateUser(UsersCompanion user) => update(users).replace(user);
  Future<void> deleteUser(String id) => (delete(users)..where((u) => u.id.equals(id))).go();
  Future<User?> getUser(String id) => (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  Future<List<User>> getAllUsers() => select(users).get();
}

@DriftAccessor(tables: [Watersheds, WatershedBoundaries])
class WatershedDao extends DatabaseAccessor<AppDatabase> with _$WatershedDaoMixin {
  WatershedDao(super.db);

  Future<void> insertWatershed(WatershedsCompanion watershed) => into(watersheds).insert(watershed);
  Future<void> insertWatersheds(List<WatershedsCompanion> watershedsList) => batch((b) => b.insertAll(watersheds, watershedsList));
  Future<void> updateWatershed(WatershedsCompanion watershed) => update(watersheds).replace(watershed);
  Future<void> deleteWatershed(String id) => (delete(watersheds)..where((w) => w.id.equals(id))).go();
  Future<Watershed?> getWatershed(String id) => (select(watersheds)..where((w) => w.id.equals(id))).getSingleOrNull();
  Future<List<Watershed>> getAllWatersheds() => select(watersheds).get();
  Future<List<Watershed>> getWatershedsByProgram(String programId) =>
      (select(watersheds)..where((w) => w.programIds.contains(programId))).get();

  Future<void> insertBoundary(WatershedBoundariesCompanion boundary) => into(watershedBoundaries).insert(boundary);
  Future<WatershedBoundary?> getBoundary(String watershedId) =>
      (select(watershedBoundaries)..where((b) => b.watershedId.equals(watershedId))).getSingleOrNull();
}

@DriftAccessor(tables: [Observations])
class ObservationDao extends DatabaseAccessor<AppDatabase> with _$ObservationDaoMixin {
  ObservationDao(super.db);

  Future<void> insertObservation(ObservationsCompanion observation) => into(observations).insert(observation);
  Future<void> insertObservations(List<ObservationsCompanion> observationsList) => batch((b) => b.insertAll(observations, observationsList));
  Future<void> updateObservation(ObservationsCompanion observation) => update(observations).replace(observation);
  Future<void> deleteObservation(String id) => (delete(observations)..where((o) => o.id.equals(id))).go();
  Future<Observation?> getObservation(String id) => (select(observations)..where((o) => o.id.equals(id))).getSingleOrNull();
  Future<List<Observation>> getAllObservations() => select(observations).get();
  Future<List<Observation>> getObservationsByWatershed(String watershedId) =>
      (select(observations)..where((o) => o.watershedId.equals(watershedId))).get();
  Future<List<Observation>> getObservationsByUser(String userId) =>
      (select(observations)..where((o) => o.userId.equals(userId))).get();
  Future<List<Observation>> getPendingSyncObservations() =>
      (select(observations)..where((o) => o.status.equals('pending') | o.status.equals('draft'))).get();
  Future<List<Observation>> getDraftObservations() =>
      (select(observations)..where((o) => o.status.equals('draft'))).get();
}

@DriftAccessor(tables: [Interventions])
class InterventionDao extends DatabaseAccessor<AppDatabase> with _$InterventionDaoMixin {
  InterventionDao(super.db);

  Future<void> insertIntervention(InterventionsCompanion intervention) => into(interventions).insert(intervention);
  Future<void> insertInterventions(List<InterventionsCompanion> interventionsList) => batch((b) => b.insertAll(interventions, interventionsList));
  Future<void> updateIntervention(InterventionsCompanion intervention) => update(interventions).replace(intervention);
  Future<void> deleteIntervention(String id) => (delete(interventions)..where((i) => i.id.equals(id))).go();
  Future<Intervention?> getIntervention(String id) => (select(interventions)..where((i) => i.id.equals(id))).getSingleOrNull();
  Future<List<Intervention>> getAllInterventions() => select(interventions).get();
  Future<List<Intervention>> getInterventionsByWatershed(String watershedId) =>
      (select(interventions)..where((i) => i.watershedId.equals(watershedId))).get();
}

@DriftAccessor(tables: [Photos])
class PhotoDao extends DatabaseAccessor<AppDatabase> with _$PhotoDaoMixin {
  PhotoDao(super.db);

  Future<void> insertPhoto(PhotosCompanion photo) => into(photos).insert(photo);
  Future<void> insertPhotos(List<PhotosCompanion> photosList) => batch((b) => b.insertAll(photos, photosList));
  Future<void> updatePhoto(PhotosCompanion photo) => update(photos).replace(photo);
  Future<void> deletePhoto(String id) => (delete(photos)..where((p) => p.id.equals(id))).go();
  Future<Photo?> getPhoto(String id) => (select(photos)..where((p) => p.id.equals(id))).getSingleOrNull();
  Future<List<Photo>> getPhotosByObservation(String observationId) =>
      (select(photos)..where((p) => p.observationId.equals(observationId))).get();
  Future<List<Photo>> getPendingUploadPhotos() =>
      (select(photos)..where((p) => p.status.equals('local') | p.status.equals('uploading'))).get();
}

@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase> with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<void> enqueue(SyncQueueCompanion item) => into(syncQueue).insert(item);
  Future<void> enqueueAll(List<SyncQueueCompanion> items) => batch((b) => b.insertAll(syncQueue, items));
  Future<void> updateItem(SyncQueueCompanion item) => update(syncQueue).replace(item);
  Future<void> deleteItem(String id) => (delete(syncQueue)..where((s) => s.id.equals(id))).go();
  Future<SyncQueueData?> getItem(String id) => (select(syncQueue)..where((s) => s.id.equals(id))).getSingleOrNull();
  Future<List<SyncQueueData>> getPendingItems() =>
      (select(syncQueue)..where((s) => s.status.equals('pending'))).get();
  Future<List<SyncQueueData>> getFailedItems({int maxRetries = 3}) =>
      (select(syncQueue)..where((s) => s.status.equals('failed') & s.retryCount.isSmallerThanValue(maxRetries))).get();
  Future<List<SyncQueueData>> getAllItems() => select(syncQueue).get();
  Future<int> getPendingCount() => (select(syncQueue)..where((s) => s.status.equals('pending'))).get().then((list) => list.length);
}