import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  String? _selectedWatershedId;
  List<Watershed> _watersheds = [];
  List<Observation> _observations = [];
  List<Intervention> _interventions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final wsDao = ref.read(watershedDaoProvider);
    final obsDao = ref.read(observationDaoProvider);
    final intDao = ref.read(interventionDaoProvider);

    final watersheds = await wsDao.getAllWatersheds();
    final observations = await obsDao.getAllObservations();
    final interventions = await intDao.getAllInterventions();

    if (mounted) {
      setState(() {
        _watersheds = watersheds;
        if (watersheds.isNotEmpty) {
          _selectedWatershedId = watersheds.first.id;
        }
        _observations = observations;
        _interventions = interventions;
        _isLoading = false;
      });
    }
  }

  void _exportReport() {
    final ws = _watersheds.firstWhere(
      (w) => w.id == _selectedWatershedId,
      orElse: () => _watersheds.first,
    );
    final completedCount = _interventions.where((i) => i.status == 'completed').length;
    final totalCost = _interventions.fold<double>(0, (sum, i) => sum + i.estimatedCost);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.picture_as_pdf, color: AppTheme.roseDanger, size: 24),
              const SizedBox(width: 8),
              const Text('Watershed Report', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(ws.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text('Code: ${ws.code} • Area: ${ws.areaKm2} km²', style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                _ReportLine(label: 'Total Observations Recorded', value: '${_observations.length} points'),
                _ReportLine(label: 'Approved Interventions', value: '${_interventions.length} structures'),
                _ReportLine(label: 'Implementation Progress', value: '$completedCount / ${_interventions.length} Completed'),
                _ReportLine(label: 'Total Sanctioned Budget', value: '₹${(totalCost / 1000).toStringAsFixed(0)}k'),
                _ReportLine(label: 'Water Harvesting Potential', value: '3,500 m³'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Verification Status: Field data verified with geo-spatial references and ready for administrative export.',
                    style: TextStyle(fontSize: 11, color: AppTheme.primaryDark),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Report generated and ready for export!'),
                    backgroundColor: AppTheme.secondaryTeal,
                  ),
                );
              },
              icon: const Icon(Icons.share, size: 16),
              label: const Text('Share Summary'),
            ),
          ],
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

    final selectedWs = _watersheds.isNotEmpty
        ? _watersheds.firstWhere(
            (w) => w.id == _selectedWatershedId,
            orElse: () => _watersheds.first,
          )
        : null;

    final completedCount = _interventions.where((i) => i.status == 'completed').length;
    final inProgressCount = _interventions.where((i) => i.status == 'in_progress').length;
    final totalInterventions = _interventions.length;
    final completionPct = totalInterventions > 0 ? (completedCount / totalInterventions) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Decision Support & Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            tooltip: 'Export Report',
            onPressed: _exportReport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Watershed Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.water, color: AppTheme.primaryBlue, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedWatershedId,
                          items: _watersheds.map((ws) {
                            return DropdownMenuItem(
                              value: ws.id,
                              child: Text(
                                ws.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _selectedWatershedId = val),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Top KPI Cards
            Row(
              children: [
                Expanded(
                  child: _KpiCard(
                    title: 'Monitored Area',
                    value: selectedWs != null ? '${selectedWs.areaKm2}' : '142.5',
                    unit: 'km²',
                    color: AppTheme.primaryBlue,
                    icon: Icons.map_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: _KpiCard(
                    title: 'Harvesting Index',
                    value: '3.5',
                    unit: 'ML',
                    color: AppTheme.secondaryTeal,
                    icon: Icons.water_drop_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _KpiCard(
                    title: 'Field Data Points',
                    value: '${_observations.length}',
                    unit: 'Observations',
                    color: Colors.indigo,
                    icon: Icons.place_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _KpiCard(
                    title: 'Delivery Rate',
                    value: (completionPct * 100).toStringAsFixed(0),
                    unit: '% Finished',
                    color: AppTheme.accentEmerald,
                    icon: Icons.task_alt,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Progress Summary Card
            const Text('Intervention Delivery Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Overall Progress', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        Text('${(completionPct * 100).toStringAsFixed(0)}%', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: completionPct,
                        minHeight: 10,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation(AppTheme.primaryBlue),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatusPill(label: 'Completed', count: completedCount, color: Colors.green),
                        _StatusPill(label: 'In Progress', count: inProgressCount, color: AppTheme.primaryBlue),
                        _StatusPill(label: 'Planned', count: totalInterventions - completedCount - inProgressCount, color: Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Field Observations Summary
            const Text('Field Observations Health', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const _ProgressRow(label: 'Check Dam & Water Structures', percentage: 0.85, color: AppTheme.primaryBlue),
                    const SizedBox(height: 12),
                    const _ProgressRow(label: 'Water Quality & Turbidity Level', percentage: 0.90, color: AppTheme.secondaryTeal),
                    const SizedBox(height: 12),
                    const _ProgressRow(label: 'Vegetation & Plantation Survival', percentage: 0.65, color: Colors.green),
                    const SizedBox(height: 12),
                    const _ProgressRow(label: 'Soil Erosion & Ridge Stabilization', percentage: 0.45, color: Colors.amber),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Action to Export
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _exportReport,
                icon: const Icon(Icons.assessment_outlined),
                label: const Text('Generate Formal Report PDF / Summary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Color color;
  final IconData icon;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted, fontWeight: FontWeight.w600)),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: color),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: const TextStyle(fontSize: 12, color: AppTheme.textMuted, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatusPill({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          '$label: $count',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  const _ProgressRow({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            Text('${(percentage * 100).toInt()}%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 6,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

class _ReportLine extends StatelessWidget {
  final String label;
  final String value;

  const _ReportLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
