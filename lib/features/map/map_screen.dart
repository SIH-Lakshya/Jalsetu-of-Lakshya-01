import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/location/location_service.dart';
import '../../core/services/cloud_sync_service.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  
  bool _showBoundaries = true;
  bool _showObservations = true;
  bool _showInterventions = true;
  bool _isSatelliteLayer = false;
  
  String? _selectedWatershedId;
  List<Watershed> _watersheds = [];
  List<Observation> _observations = [];
  List<Intervention> _interventions = [];
  List<LatLng> _currentBoundary = [];
  bool _isLoading = true;
  
  // Cloud sync and connectivity
  late final CloudSyncService _cloudSync;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _isOnline = false;

  @override
  void initState() {
    super.initState();
    // Initialize cloud sync after first build when ref is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cloudSync = CloudSyncService(ref.read(appDatabaseProvider));
      _initConnectivity();
      _loadData();
    });
  }

  void _initConnectivity() {
    // Check initial connectivity
    Connectivity().checkConnectivity().then((result) {
      setState(() => _isOnline = result.isNotEmpty && result.first != ConnectivityResult.none);
      if (_isOnline) {
        _syncWithCloud();
      }
    });

    // Listen for connectivity changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      final wasOnline = _isOnline;
      setState(() => _isOnline = result.isNotEmpty && result.first != ConnectivityResult.none);
      
      // If we just came online, sync with cloud
      if (!wasOnline && _isOnline) {
        _syncWithCloud();
      }
    }) as StreamSubscription<ConnectivityResult>?;
  }

  Future<void> _syncWithCloud() async {
    if (!_isOnline) return;
    
    try {
      await _cloudSync.syncAllData();
      
      // Reload data after sync
      await _loadData();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data synced with cloud'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sync failed: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final wsDao = ref.read(watershedDaoProvider);
    final obsDao = ref.read(observationDaoProvider);
    final intDao = ref.read(interventionDaoProvider);

    final watersheds = await wsDao.getAllWatersheds();
    final observations = await obsDao.getAllObservations();
    final interventions = await intDao.getAllInterventions();

    if (watersheds.isNotEmpty) {
      _selectedWatershedId = watersheds.first.id;
      final boundary = await wsDao.getBoundary(watersheds.first.id);
      if (boundary != null) {
        _currentBoundary = boundary.coordinates;
      }
    }

    if (mounted) {
      setState(() {
        _watersheds = watersheds;
        _observations = observations;
        _interventions = interventions;
        _isLoading = false;
      });
    }
  }

  Future<void> _onWatershedChanged(String? wsId) async {
    if (wsId == null) return;
    final wsDao = ref.read(watershedDaoProvider);
    final selected = _watersheds.firstWhere((w) => w.id == wsId);
    final boundary = await wsDao.getBoundary(wsId);

    setState(() {
      _selectedWatershedId = wsId;
      _currentBoundary = boundary?.coordinates ?? [];
    });

    _mapController.move(
      LatLng(selected.centerLat, selected.centerLng),
      13.5,
    );
  }

  Future<void> _centerOnUser() async {
    try {
      final loc = ref.read(locationServiceProvider);
      final pos = await loc.getCurrentPosition();
      _mapController.move(LatLng(pos.latitude, pos.longitude), 15.0);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not get GPS location: $e. Using watershed center.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        if (_watersheds.isNotEmpty) {
          final ws = _watersheds.firstWhere((w) => w.id == _selectedWatershedId, orElse: () => _watersheds.first);
          _mapController.move(LatLng(ws.centerLat, ws.centerLng), 13.5);
        }
      }
    }
  }

  void _showObservationDetails(Observation obs) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.water_drop, color: AppTheme.primaryBlue, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Observation #${obs.id.replaceAll('obs_', '')}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          obs.type.toUpperCase().replaceAll('_', ' '),
                          style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: obs.status == 'synced' ? Colors.green[50] : Colors.amber[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: obs.status == 'synced' ? Colors.green[200]! : Colors.amber[200]!,
                      ),
                    ),
                    child: Text(
                      obs.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: obs.status == 'synced' ? Colors.green[700] : Colors.amber[800],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                obs.notes ?? 'No notes recorded for this observation.',
                style: const TextStyle(fontSize: 14, color: AppTheme.textDark, height: 1.4),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderLight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _InfoCell(
                      label: 'Latitude',
                      value: obs.latitude.toStringAsFixed(4),
                    ),
                    _InfoCell(
                      label: 'Longitude',
                      value: obs.longitude.toStringAsFixed(4),
                    ),
                    _InfoCell(
                      label: 'Accuracy',
                      value: '±${obs.gpsAccuracy.toStringAsFixed(1)}m',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Close Details'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showInterventionDetails(Intervention intervention) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.construction, color: Color(0xFFD97706), size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          intervention.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          intervention.type.toUpperCase().replaceAll('_', ' '),
                          style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: intervention.status == 'completed'
                          ? Colors.green[50]
                          : Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: intervention.status == 'completed'
                            ? Colors.green[200]!
                            : Colors.blue[200]!,
                      ),
                    ),
                    child: Text(
                      intervention.status.toUpperCase().replaceAll('_', ' '),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: intervention.status == 'completed'
                            ? Colors.green[700]
                            : Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                intervention.description,
                style: const TextStyle(fontSize: 14, color: AppTheme.textDark, height: 1.4),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderLight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _InfoCell(
                      label: 'Est. Budget',
                      value: '₹${(intervention.estimatedCost / 1000).toStringAsFixed(0)}k',
                    ),
                    _InfoCell(
                      label: 'Actual Cost',
                      value: intervention.actualCost != null
                          ? '₹${(intervention.actualCost! / 1000).toStringAsFixed(0)}k'
                          : 'In Progress',
                    ),
                    _InfoCell(
                      label: 'Contractor',
                      value: intervention.contractor?.split(' ').first ?? 'N/A',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final initialCenter = _watersheds.isNotEmpty
        ? LatLng(_watersheds.first.centerLat, _watersheds.first.centerLng)
        : const LatLng(19.9975, 73.7898);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watershed GIS Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_location_alt_outlined),
            tooltip: 'New Observation',
            onPressed: () => context.push('/observations/new'),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: 13.5,
              minZoom: 5.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: _isSatelliteLayer
                    ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
                    : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'org.jalsetu.app',
              ),
              if (_showBoundaries && _currentBoundary.isNotEmpty)
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: _currentBoundary,
                      color: AppTheme.primaryBlue.withValues(alpha: 0.15),
                      borderColor: AppTheme.primaryBlue,
                      borderStrokeWidth: 2.5,
                    ),
                  ],
                ),
              if (_showObservations)
                MarkerLayer(
                  markers: _observations.map((obs) {
                    return Marker(
                      point: LatLng(obs.latitude, obs.longitude),
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => _showObservationDetails(obs),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.primaryBlue, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.water_drop,
                            color: AppTheme.primaryBlue,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              if (_showInterventions)
                MarkerLayer(
                  markers: _interventions.map((intv) {
                    final lat = _currentBoundary.isNotEmpty
                        ? _currentBoundary.first.latitude + 0.005
                        : 20.0020;
                    final lng = _currentBoundary.isNotEmpty
                        ? _currentBoundary.first.longitude + 0.005
                        : 73.7920;
                    return Marker(
                      point: LatLng(lat, lng),
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => _showInterventionDetails(intv),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFD97706), width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.construction,
                            color: Color(0xFFD97706),
                            size: 18,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),

          // Watershed Switcher floating top card
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedWatershedId,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.primaryBlue),
                    items: _watersheds.map((ws) {
                      return DropdownMenuItem(
                        value: ws.id,
                        child: Row(
                          children: [
                            const Icon(Icons.terrain, size: 20, color: AppTheme.secondaryTeal),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ws.name,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: _onWatershedChanged,
                  ),
                ),
              ),
            ),
          ),

          // Quick GIS layer toggles and GPS control
          Positioned(
            right: 16,
            bottom: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MapFloatingButton(
                  icon: _isSatelliteLayer ? Icons.map : Icons.satellite_alt,
                  tooltip: _isSatelliteLayer ? 'Street Map' : 'Satellite Imagery',
                  onTap: () => setState(() => _isSatelliteLayer = !_isSatelliteLayer),
                ),
                const SizedBox(height: 8),
                _MapFloatingButton(
                  icon: Icons.layers,
                  tooltip: 'Layer Settings',
                  onTap: () => _showLayerFilterSheet(),
                ),
                const SizedBox(height: 8),
                _MapFloatingButton(
                  icon: Icons.my_location,
                  tooltip: 'Center Location',
                  color: AppTheme.primaryBlue,
                  iconColor: Colors.white,
                  onTap: _centerOnUser,
                ),
              ],
            ),
          ),

          // Mini Legend at bottom left
          Positioned(
            left: 16,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _LegendItem(color: AppTheme.primaryBlue, label: 'Observations'),
                  SizedBox(width: 12),
                  _LegendItem(color: Color(0xFFD97706), label: 'Interventions'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLayerFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Map Layers & Overlays', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  SwitchListTile.adaptive(
                    value: _showBoundaries,
                    activeTrackColor: AppTheme.primaryBlue,
                    title: const Text('Watershed Catchment Boundary'),
                    subtitle: const Text('High precision polygon overlay'),
                    onChanged: (val) {
                      setSheetState(() => _showBoundaries = val);
                      setState(() => _showBoundaries = val);
                    },
                  ),
                  SwitchListTile.adaptive(
                    value: _showObservations,
                    activeTrackColor: AppTheme.primaryBlue,
                    title: const Text('Field Observations'),
                    subtitle: const Text('Water quality & condition markers'),
                    onChanged: (val) {
                      setSheetState(() => _showObservations = val);
                      setState(() => _showObservations = val);
                    },
                  ),
                  SwitchListTile.adaptive(
                    value: _showInterventions,
                    activeTrackColor: AppTheme.primaryBlue,
                    title: const Text('Interventions Projects'),
                    subtitle: const Text('Check dams, percolation ponds & trenches'),
                    onChanged: (val) {
                      setSheetState(() => _showInterventions = val);
                      setState(() => _showInterventions = val);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _MapFloatingButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color color;
  final Color iconColor;

  const _MapFloatingButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.color = Colors.white,
    this.iconColor = AppTheme.textDark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: iconColor, size: 22),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _InfoCell extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }
}
