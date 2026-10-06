// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daos.dart';

// ignore_for_file: type=lint
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  UserDaoManager get managers => UserDaoManager(this);
}

class UserDaoManager {
  final _$UserDaoMixin _db;
  UserDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
}

mixin _$WatershedDaoMixin on DatabaseAccessor<AppDatabase> {
  $WatershedsTable get watersheds => attachedDatabase.watersheds;
  $WatershedBoundariesTable get watershedBoundaries =>
      attachedDatabase.watershedBoundaries;
  WatershedDaoManager get managers => WatershedDaoManager(this);
}

class WatershedDaoManager {
  final _$WatershedDaoMixin _db;
  WatershedDaoManager(this._db);
  $$WatershedsTableTableManager get watersheds =>
      $$WatershedsTableTableManager(_db.attachedDatabase, _db.watersheds);
  $$WatershedBoundariesTableTableManager get watershedBoundaries =>
      $$WatershedBoundariesTableTableManager(
        _db.attachedDatabase,
        _db.watershedBoundaries,
      );
}

mixin _$ObservationDaoMixin on DatabaseAccessor<AppDatabase> {
  $ObservationsTable get observations => attachedDatabase.observations;
  ObservationDaoManager get managers => ObservationDaoManager(this);
}

class ObservationDaoManager {
  final _$ObservationDaoMixin _db;
  ObservationDaoManager(this._db);
  $$ObservationsTableTableManager get observations =>
      $$ObservationsTableTableManager(_db.attachedDatabase, _db.observations);
}

mixin _$InterventionDaoMixin on DatabaseAccessor<AppDatabase> {
  $InterventionsTable get interventions => attachedDatabase.interventions;
  InterventionDaoManager get managers => InterventionDaoManager(this);
}

class InterventionDaoManager {
  final _$InterventionDaoMixin _db;
  InterventionDaoManager(this._db);
  $$InterventionsTableTableManager get interventions =>
      $$InterventionsTableTableManager(_db.attachedDatabase, _db.interventions);
}

mixin _$PhotoDaoMixin on DatabaseAccessor<AppDatabase> {
  $PhotosTable get photos => attachedDatabase.photos;
  PhotoDaoManager get managers => PhotoDaoManager(this);
}

class PhotoDaoManager {
  final _$PhotoDaoMixin _db;
  PhotoDaoManager(this._db);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db.attachedDatabase, _db.photos);
}

mixin _$SyncQueueDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncQueueTable get syncQueue => attachedDatabase.syncQueue;
  SyncQueueDaoManager get managers => SyncQueueDaoManager(this);
}

class SyncQueueDaoManager {
  final _$SyncQueueDaoMixin _db;
  SyncQueueDaoManager(this._db);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db.attachedDatabase, _db.syncQueue);
}
