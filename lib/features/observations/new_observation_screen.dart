import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../../app/theme.dart';
import '../../core/auth/auth_state.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/location/location_service.dart';

class NewObservationScreen extends ConsumerStatefulWidget {
  const NewObservationScreen({super.key});

  @override
  ConsumerState<NewObservationScreen> createState() => _NewObservationScreenState();
}

class _NewObservationScreenState extends ConsumerState<NewObservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final _waterLevelController = TextEditingController(text: '1.5');

  String? _selectedWatershedId;
  String _selectedType = 'water_quality';
  String _selectedCondition = 'Good';
  double _latitude = 19.9975;
  double _longitude = 73.7898;
  double _accuracy = 4.2;
  bool _isLocating = false;
  bool _isSaving = false;

  final List<XFile> _capturedImages = [];
  final ImagePicker _picker = ImagePicker();

  List<Watershed> _watersheds = [];

  final List<Map<String, dynamic>> _categories = [
    {'type': 'water_quality', 'label': 'Water Quality', 'icon': Icons.water_drop},
    {'type': 'intervention', 'label': 'Check Dam / Structure', 'icon': Icons.construction},
    {'type': 'condition', 'label': 'Soil & Gully Erosion', 'icon': Icons.terrain},
    {'type': 'vegetation', 'label': 'Plantation / Green Cover', 'icon': Icons.forest},
    {'type': 'soil', 'label': 'Soil Moisture', 'icon': Icons.grass},
    {'type': 'other', 'label': 'Other Field Note', 'icon': Icons.note_alt},
  ];

  @override
  void initState() {
    super.initState();
    _loadWatersheds();
    _fetchGpsLocation();
  }

  @override
  void dispose() {
    _notesController.dispose();
    _waterLevelController.dispose();
    super.dispose();
  }

  Future<void> _loadWatersheds() async {
    final wsDao = ref.read(watershedDaoProvider);
    final list = await wsDao.getAllWatersheds();
    if (mounted && list.isNotEmpty) {
      setState(() {
        _watersheds = list;
        _selectedWatershedId = list.first.id;
        _latitude = list.first.centerLat;
        _longitude = list.first.centerLng;
      });
    }
  }

  Future<void> _fetchGpsLocation() async {
    setState(() => _isLocating = true);
    try {
      final loc = ref.read(locationServiceProvider);
      final pos = await loc.getCurrentPosition();
      if (mounted) {
        setState(() {
          _latitude = pos.latitude;
          _longitude = pos.longitude;
          _accuracy = pos.accuracy;
          _isLocating = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLocating = false;
          // default coordinate is preserved
        });
      }
    }
  }

  Future<void> _takePhoto(ImageSource source) async {
    try {
      final photo = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
      );
      if (photo != null && mounted) {
        setState(() => _capturedImages.add(photo));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo capture not supported on this platform: $e')),
        );
      }
    }
  }

  Future<void> _saveObservation({required bool isDraft}) async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedWatershedId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a watershed')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final obsDao = ref.read(observationDaoProvider);
      final syncDao = ref.read(syncQueueDaoProvider);
      final user = ref.read(authStateProvider).value;

      final obsId = 'obs_${const Uuid().v4().substring(0, 8)}';
      final status = isDraft ? 'draft' : 'pending';

      final companion = ObservationsCompanion(
        id: drift.Value(obsId),
        watershedId: drift.Value(_selectedWatershedId!),
        userId: drift.Value(user?.id ?? 'field_officer_01'),
        type: drift.Value(_selectedType),
        status: drift.Value(status),
        latitude: drift.Value(_latitude),
        longitude: drift.Value(_longitude),
        gpsAccuracy: drift.Value(_accuracy),
        timestamp: drift.Value(DateTime.now()),
        notes: drift.Value(_notesController.text.trim()),
        photoIds: drift.Value(_capturedImages.map((e) => e.path).toList()),
        interventionId: const drift.Value(null),
        metadata: drift.Value({
          'condition': _selectedCondition,
          'water_level_m': double.tryParse(_waterLevelController.text) ?? 1.5,
          'photos_count': _capturedImages.length,
        }),
        createdAt: drift.Value(DateTime.now()),
        updatedAt: drift.Value(DateTime.now()),
      );

      await obsDao.insertObservation(companion);

      if (!isDraft) {
        await syncDao.enqueue(SyncQueueCompanion(
          id: drift.Value('sync_${const Uuid().v4().substring(0, 8)}'),
          entityType: const drift.Value('observation'),
          entityId: drift.Value(obsId),
          operation: const drift.Value('create'),
          payload: drift.Value({'observation_id': obsId, 'type': _selectedType}),
          retryCount: const drift.Value(0),
          createdAt: drift.Value(DateTime.now()),
          status: const drift.Value('pending'),
        ));
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.secondaryTeal,
            content: Text(
              isDraft
                  ? 'Observation draft saved locally'
                  : 'Observation queued for synchronization',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving observation: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Field Observation'),
        actions: [
          TextButton.icon(
            onPressed: _isSaving ? null : () => _saveObservation(isDraft: true),
            icon: const Icon(Icons.bookmark_outline, size: 18),
            label: const Text('Save Draft'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Watershed Picker Card
              const Text('Watershed Area', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedWatershedId,
                      hint: const Text('Select target watershed'),
                      items: _watersheds.map((ws) {
                        return DropdownMenuItem(
                          value: ws.id,
                          child: Text(ws.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedWatershedId = val),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Category Selector
              const Text('Observation Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((cat) {
                  final isSelected = _selectedType == cat['type'];
                  return ChoiceChip(
                    avatar: Icon(
                      cat['icon'] as IconData,
                      size: 16,
                      color: isSelected ? Colors.white : AppTheme.primaryBlue,
                    ),
                    label: Text(cat['label'] as String),
                    selected: isSelected,
                    selectedColor: AppTheme.primaryBlue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.textDark,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedType = cat['type'] as String);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // GPS Coordinates Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.location_on, color: AppTheme.primaryBlue, size: 20),
                              SizedBox(width: 8),
                              Text('Geo-Coordinates', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '±${_accuracy.toStringAsFixed(1)}m GPS Accuracy',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryDark),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Lat: ${_latitude.toStringAsFixed(5)}, Lng: ${_longitude.toStringAsFixed(5)}',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _isLocating ? null : _fetchGpsLocation,
                            icon: _isLocating
                                ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
                                : const Icon(Icons.refresh, size: 16),
                            label: const Text('Refresh GPS'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Condition Rating
              const Text('Physical Condition / Assessment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 10),
              Row(
                children: ['Good', 'Moderate', 'Degraded', 'Critical'].map((cond) {
                  final isSelected = _selectedCondition == cond;
                  Color pillColor;
                  switch (cond) {
                    case 'Good':
                      pillColor = Colors.green;
                      break;
                    case 'Moderate':
                      pillColor = Colors.blue;
                      break;
                    case 'Degraded':
                      pillColor = Colors.orange;
                      break;
                    default:
                      pillColor = Colors.red;
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () => setState(() => _selectedCondition = cond),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? pillColor.withValues(alpha: 0.15) : AppTheme.backgroundLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ? pillColor : AppTheme.borderLight,
                              width: isSelected ? 1.8 : 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              cond,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? pillColor : AppTheme.textMuted,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Photos Card
              const Text('Geo-Tagged Field Photos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              if (_capturedImages.isNotEmpty) ...[
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _capturedImages.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(_capturedImages[index].path),
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => setState(() => _capturedImages.removeAt(index)),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, color: Colors.white, size: 14),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _takePhoto(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt, size: 18),
                      label: const Text('Take Photo'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _takePhoto(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library, size: 18),
                      label: const Text('Add Gallery'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Field Notes
              const Text('Observation Notes & Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Enter specific field notes, water clarity, siltation status, or remarks...',
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter notes' : null,
              ),
              const SizedBox(height: 28),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSaving ? null : () => _saveObservation(isDraft: false),
                  icon: _isSaving
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Icon(Icons.cloud_upload_outlined, size: 20),
                  label: Text(_isSaving ? 'Submitting...' : 'Submit Observation'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
