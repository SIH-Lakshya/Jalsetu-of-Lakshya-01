import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart' as db;
import '../database/daos.dart';
import '../models/observation.dart' as model_obs;
import '../models/intervention.dart' as model_int;
import '../models/photo.dart';

class CloudSyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final db.AppDatabase _localDb;
  
  // DAOs
  late final ObservationDao _observationDao;
  late final InterventionDao _interventionDao;
  late final PhotoDao _photoDao;

  CloudSyncService(this._localDb) {
    _observationDao = ObservationDao(_localDb);
    _interventionDao = InterventionDao(_localDb);
    _photoDao = PhotoDao(_localDb);
  }

  // Check if user is authenticated
  Future<bool> get isAuthenticated async {
    return _auth.currentUser != null;
  }

  // Sign in anonymously (for simplicity - adjust based on your auth needs)
  Future<void> signInAnonymously() async {
    if (!await isAuthenticated) {
      await _auth.signInAnonymously();
    }
  }

  // Sync observations to cloud
  Future<void> syncObservations() async {
    try {
      await signInAnonymously();
      
      final localObs = await _observationDao.getAllObservations();
      
      for (final obs in localObs) {
        // Skip if already synced and not modified recently
        if (obs.status == model_obs.ObservationStatus.synced.name && 
            obs.syncedAt != null && 
            DateTime.now().difference(obs.syncedAt!).inHours < 1) {
          continue;
        }

        final docRef = _firestore
            .collection('watersheds')
            .doc(obs.watershedId)
            .collection('observations')
            .doc(obs.id);
        
        await docRef.set(obs.toJson(), SetOptions(merge: true));
        
        // Update local status to synced
        await _observationDao.updateObservation(
          db.ObservationsCompanion(
            id: Value(obs.id),
            status: Value(model_obs.ObservationStatus.synced.name),
            syncedAt: Value(DateTime.now()),
          ),
        );
      }
    } catch (e) {
      // Handle sync errors - could add to sync queue for retry
      log('Error syncing observations: $e');
    }
  }

  // Sync interventions to cloud
  Future<void> syncInterventions() async {
    try {
      await signInAnonymously();
      
      final localInt = await _interventionDao.getAllInterventions();
      
      for (final intv in localInt) {
        // Skip if already synced and not modified recently
        if (intv.status == model_int.InterventionStatus.completed.name || intv.status == model_int.InterventionStatus.verified.name) {
          continue;
        }

        final docRef = _firestore
            .collection('watersheds')
            .doc(intv.watershedId)
            .collection('interventions')
            .doc(intv.id);
        
        await docRef.set(intv.toJson(), SetOptions(merge: true));
        
        // Update local status
        await _interventionDao.updateIntervention(
          db.InterventionsCompanion(
            id: Value(intv.id),
            status: Value(model_int.InterventionStatus.verified.name),
          ),
        );
      }
    } catch (e) {
      log('Error syncing interventions: $e');
    }
  }

  // Sync photos to cloud storage
  Future<void> syncPhotos() async {
    try {
      await signInAnonymously();
      
      final pendingPhotos = await _photoDao.getPendingUploadPhotos();
      
      for (final photo in pendingPhotos) {
        try {
          // Upload photo to Firebase Storage
          final file = File(photo.localPath);
          final fileName = 'photos/${photo.id}.jpg';
          final ref = _storage.ref().child(fileName);
          
          await ref.putFile(file);
          final downloadUrl = await ref.getDownloadURL();
          
          // Update photo record with URL and status
          await _photoDao.updatePhoto(
            db.PhotosCompanion(
              id: Value(photo.id),
              remoteUrl: Value(downloadUrl),
              status: Value(PhotoStatus.uploaded.name),
              uploadedAt: Value(DateTime.now()),
            ),
          );
        } catch (e) {
          log('Error uploading photo ${photo.id}: $e');
          // Keep as local for retry
        }
      }
    } catch (e) {
      log('Error syncing photos: $e');
    }
  }

  // Listen for cloud changes and update local DB
  void listenForCloudChanges(String watershedId, Function onUpdate) {
    try {
      // Listen for observation changes
      _firestore
          .collection('watersheds')
          .doc(watershedId)
          .collection('observations')
          .snapshots()
          .listen((snapshot) {
        for (final change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added ||
              change.type == DocumentChangeType.modified) {
            final obsData = change.doc.data();
            if (obsData != null) {
              final obs = model_obs.Observation.fromJson(obsData);
              // Update local DB if cloud version is newer
              _observationDao.updateObservation(
                db.ObservationsCompanion(
                  id: Value(obs.id),
                  watershedId: Value(obs.watershedId),
                  userId: Value(obs.userId),
                  type: Value(obs.type.name),
                  status: Value(obs.status.name),
                  latitude: Value(obs.location.latitude),
                  longitude: Value(obs.location.longitude),
                  gpsAccuracy: Value(obs.gpsAccuracy),
                  timestamp: Value(obs.timestamp),
                  notes: Value(obs.notes ?? ''),
                  photoIds: Value(obs.photoIds ?? []),
                  interventionId: Value(obs.interventionId ?? ''),
                  metadata: Value(obs.metadata ?? {}),
                  createdAt: Value(obs.createdAt ?? DateTime.now()),
                  updatedAt: Value(obs.updatedAt ?? DateTime.now()),
                  syncedAt: Value(obs.syncedAt),
                ),
              );
              onUpdate();
            }
          }
        }
      });

      // Listen for intervention changes
      _firestore
          .collection('watersheds')
          .doc(watershedId)
          .collection('interventions')
          .snapshots()
          .listen((snapshot) {
        for (final change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added ||
              change.type == DocumentChangeType.modified) {
            final intvData = change.doc.data();
            if (intvData != null) {
              final intv = model_int.Intervention.fromJson(intvData);
              // Update local DB
              _interventionDao.updateIntervention(
                db.InterventionsCompanion(
                  id: Value(intv.id),
                  watershedId: Value(intv.watershedId),
                  name: Value(intv.name),
                  type: Value(intv.type.name),
                  status: Value(intv.status.name),
                  description: Value(intv.description),
                  plannedDate: Value(intv.plannedDate),
                  actualDate: Value(intv.actualDate),
                  estimatedCost: Value(intv.estimatedCost),
                  actualCost: Value(intv.actualCost),
                  contractor: Value(intv.contractor ?? ''),
                  photoIds: Value(intv.photoIds ?? []),
                  metadata: Value(intv.metadata ?? {}),
                  createdAt: Value(intv.createdAt ?? DateTime.now()),
                  updatedAt: Value(intv.updatedAt ?? DateTime.now()),
                ),
              );
              onUpdate();
            }
          }
        }
      });
    } catch (e) {
      log('Error setting up cloud listeners: $e');
    }
  }

  // Manual sync all data
  Future<void> syncAllData() async {
    await syncObservations();
    await syncInterventions();
    await syncPhotos();
  }

  // Check connectivity status
  Future<bool> get isOnline async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      return connectivity.isNotEmpty && connectivity.first != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }
}