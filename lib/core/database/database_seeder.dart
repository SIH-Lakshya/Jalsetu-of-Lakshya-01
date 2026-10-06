import 'package:drift/drift.dart';
import 'package:latlong2/latlong.dart';
import 'app_database.dart';
import 'daos.dart';

class DatabaseSeeder {
  static Future<void> seedIfEmpty(AppDatabase db) async {
    final watershedDao = WatershedDao(db);
    final existing = await watershedDao.getAllWatersheds();
    if (existing.isNotEmpty) return;

    // Seed Watersheds
    final ws1Id = 'ws_godavari_01';
    final ws2Id = 'ws_narmada_02';
    final ws3Id = 'ws_kaveri_03';

    await watershedDao.insertWatershed(WatershedsCompanion(
      id: Value(ws1Id),
      name: const Value('Upper Godavari Catchment Block-7'),
      code: const Value('GDV-07-MH'),
      description: const Value('Catchment area covering Western Ghats rain-shadow agricultural watershed with critical rainwater harvesting needs.'),
      centerLat: const Value(19.9975),
      centerLng: const Value(73.7898),
      areaKm2: const Value(142.5),
      state: const Value('Maharashtra'),
      district: const Value('Nashik'),
      programIds: const Value(['PMKSY-WDC', 'JAL-SHAKTI-2026']),
      createdAt: Value(DateTime.now().subtract(const Duration(days: 90))),
      updatedAt: Value(DateTime.now()),
    ));

    await watershedDao.insertBoundary(WatershedBoundariesCompanion(
      watershedId: Value(ws1Id),
      coordinates: Value([
        LatLng(19.980, 73.760),
        LatLng(20.020, 73.770),
        LatLng(20.035, 73.810),
        LatLng(20.010, 73.830),
        LatLng(19.975, 73.805),
        LatLng(19.980, 73.760),
      ]),
      geometryType: const Value('Polygon'),
    ));

    await watershedDao.insertWatershed(WatershedsCompanion(
      id: Value(ws2Id),
      name: const Value('Narmada Valley Micro-Basin 4B'),
      code: const Value('NRM-4B-MP'),
      description: const Value('Mixed forested and dryland agriculture catchment focus area for spring rejuvenation and check dams.'),
      centerLat: const Value(22.7196),
      centerLng: const Value(75.8577),
      areaKm2: const Value(88.3),
      state: const Value('Madhya Pradesh'),
      district: const Value('Indore'),
      programIds: const Value(['ATAL-BHUJAL', 'MGNREGS-WATER']),
      createdAt: Value(DateTime.now().subtract(const Duration(days: 60))),
      updatedAt: Value(DateTime.now()),
    ));

    await watershedDao.insertBoundary(WatershedBoundariesCompanion(
      watershedId: Value(ws2Id),
      coordinates: Value([
        LatLng(22.700, 75.840),
        LatLng(22.740, 75.845),
        LatLng(22.750, 75.880),
        LatLng(22.715, 75.890),
        LatLng(22.700, 75.840),
      ]),
      geometryType: const Value('Polygon'),
    ));

    await watershedDao.insertWatershed(WatershedsCompanion(
      id: Value(ws3Id),
      name: const Value('Kaveri Tributary Sub-Catchment'),
      code: const Value('KVR-12-KA'),
      description: const Value('Semi-arid highland catchment with community farm ponds and continuous contour trenches.'),
      centerLat: const Value(12.2958),
      centerLng: const Value(76.6394),
      areaKm2: const Value(116.0),
      state: const Value('Karnataka'),
      district: const Value('Mysuru'),
      programIds: const Value(['PMKSY-WDC']),
      createdAt: Value(DateTime.now().subtract(const Duration(days: 45))),
      updatedAt: Value(DateTime.now()),
    ));

    // Seed Interventions
    final interventionDao = InterventionDao(db);
    await interventionDao.insertInterventions([
      InterventionsCompanion(
        id: const Value('int_gdv_01'),
        watershedId: Value(ws1Id),
        name: const Value('Masonry Check Dam - Stream 4'),
        type: const Value('check_dam'),
        status: const Value('completed'),
        description: const Value('Concrete masonry check dam with 12m crest length to arrest siltation and store 3500 m³ water.'),
        plannedDate: Value(DateTime.now().subtract(const Duration(days: 75))),
        actualDate: Value(DateTime.now().subtract(const Duration(days: 15))),
        estimatedCost: const Value(450000.0),
        actualCost: const Value(425000.0),
        contractor: const Value('Sahyadri Infrastructure Works'),
        photoIds: const Value([]),
        metadata: const Value({'capacity_m3': 3500, 'crest_height_m': 2.5}),
        createdAt: Value(DateTime.now().subtract(const Duration(days: 75))),
        updatedAt: Value(DateTime.now().subtract(const Duration(days: 15))),
      ),
      InterventionsCompanion(
        id: const Value('int_gdv_02'),
        watershedId: Value(ws1Id),
        name: const Value('Community Percolation Tank B'),
        type: const Value('percolation_tank'),
        status: const Value('in_progress'),
        description: const Value('Percolation pond to recharge shallow basaltic aquifer serving 45 farm borewells.'),
        plannedDate: Value(DateTime.now().subtract(const Duration(days: 40))),
        actualDate: const Value(null),
        estimatedCost: const Value(380000.0),
        actualCost: const Value(210000.0),
        contractor: const Value('Rural Jal Vikas Kendra'),
        photoIds: const Value([]),
        metadata: const Value({'progress_percent': 65, 'depth_m': 3.2}),
        createdAt: Value(DateTime.now().subtract(const Duration(days: 40))),
        updatedAt: Value(DateTime.now()),
      ),
      InterventionsCompanion(
        id: const Value('int_gdv_03'),
        watershedId: Value(ws1Id),
        name: const Value('Hill Slope Continuous Contour Trenches'),
        type: const Value('contour_trench'),
        status: const Value('planned'),
        description: const Value('1.8 km continuous contour trenches with vetiver grass hedgerows on 8% upper slope.'),
        plannedDate: Value(DateTime.now().add(const Duration(days: 20))),
        actualDate: const Value(null),
        estimatedCost: const Value(220000.0),
        actualCost: const Value(0.0),
        contractor: const Value('Village Watershed Committee'),
        photoIds: const Value([]),
        metadata: const Value({'length_meters': 1800}),
        createdAt: Value(DateTime.now().subtract(const Duration(days: 10))),
        updatedAt: Value(DateTime.now()),
      ),
      InterventionsCompanion(
        id: const Value('int_nrm_01'),
        watershedId: Value(ws2Id),
        name: const Value('Springhead Rejuvenation & Protection Chamber'),
        type: const Value('recharge_shaft'),
        status: const Value('completed'),
        description: const Value('Infiltration trenches upstream and spring tapping chamber supplying domestic water.'),
        plannedDate: Value(DateTime.now().subtract(const Duration(days: 50))),
        actualDate: Value(DateTime.now().subtract(const Duration(days: 5))),
        estimatedCost: const Value(175000.0),
        actualCost: const Value(170000.0),
        contractor: const Value('EcoHydrology Associates'),
        photoIds: const Value([]),
        metadata: const Value({'discharge_lpm': 42}),
        createdAt: Value(DateTime.now().subtract(const Duration(days: 50))),
        updatedAt: Value(DateTime.now()),
      ),
    ]);

    // Seed Observations
    final observationDao = ObservationDao(db);
    await observationDao.insertObservations([
      ObservationsCompanion(
        id: const Value('obs_001'),
        watershedId: Value(ws1Id),
        userId: const Value('user_field_01'),
        type: const Value('water_quality'),
        status: const Value('synced'),
        latitude: const Value(19.9950),
        longitude: const Value(73.7850),
        gpsAccuracy: const Value(4.2),
        timestamp: Value(DateTime.now().subtract(const Duration(days: 2, hours: 3))),
        notes: const Value('Check dam reservoir water is clear. Minimal turbidity observed. Local farmers pumping for rabi gram crop.'),
        photoIds: const Value([]),
        interventionId: const Value('int_gdv_01'),
        metadata: const Value({'turbidity_ntu': 12, 'water_level_m': 1.8, 'condition': 'Good'}),
        createdAt: Value(DateTime.now().subtract(const Duration(days: 2))),
        updatedAt: Value(DateTime.now().subtract(const Duration(days: 2))),
        syncedAt: Value(DateTime.now().subtract(const Duration(days: 2))),
      ),
      ObservationsCompanion(
        id: const Value('obs_002'),
        watershedId: Value(ws1Id),
        userId: const Value('user_field_01'),
        type: const Value('intervention'),
        status: const Value('synced'),
        latitude: const Value(20.0020),
        longitude: const Value(73.7920),
        gpsAccuracy: const Value(5.8),
        timestamp: Value(DateTime.now().subtract(const Duration(days: 1, hours: 5))),
        notes: const Value('Percolation tank excavation in final stages. Bed desiltation completed. Spillway stone pitching underway.'),
        photoIds: const Value([]),
        interventionId: const Value('int_gdv_02'),
        metadata: const Value({'progress': '65%', 'condition': 'Good'}),
        createdAt: Value(DateTime.now().subtract(const Duration(days: 1))),
        updatedAt: Value(DateTime.now().subtract(const Duration(days: 1))),
        syncedAt: Value(DateTime.now().subtract(const Duration(days: 1))),
      ),
      ObservationsCompanion(
        id: const Value('obs_003'),
        watershedId: Value(ws1Id),
        userId: const Value('user_field_01'),
        type: const Value('condition'),
        status: const Value('pending'),
        latitude: const Value(19.9880),
        longitude: const Value(73.7740),
        gpsAccuracy: const Value(3.5),
        timestamp: Value(DateTime.now().subtract(const Duration(hours: 4))),
        notes: const Value('Active gully erosion spotted on western ridge following unseasonal rainfall. Requires loose boulder structure.'),
        photoIds: const Value([]),
        interventionId: const Value(null),
        metadata: const Value({'severity': 'High', 'condition': 'Degraded'}),
        createdAt: Value(DateTime.now().subtract(const Duration(hours: 4))),
        updatedAt: Value(DateTime.now().subtract(const Duration(hours: 4))),
        syncedAt: const Value(null),
      ),
    ]);

    // Seed initial sync queue item
    final syncDao = SyncQueueDao(db);
    await syncDao.enqueue(SyncQueueCompanion(
      id: const Value('sync_item_001'),
      entityType: const Value('observation'),
      entityId: const Value('obs_003'),
      operation: const Value('create'),
      payload: const Value({'observation_id': 'obs_003', 'type': 'condition'}),
      retryCount: const Value(0),
      createdAt: Value(DateTime.now().subtract(const Duration(hours: 4))),
      status: const Value('pending'),
    ));
  }
}
