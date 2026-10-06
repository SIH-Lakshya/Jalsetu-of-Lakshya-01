import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';

class InterventionsScreen extends ConsumerStatefulWidget {
  const InterventionsScreen({super.key});

  @override
  ConsumerState<InterventionsScreen> createState() => _InterventionsScreenState();
}

class _InterventionsScreenState extends ConsumerState<InterventionsScreen> {
  String _selectedFilter = 'all';
  String _searchQuery = '';
  List<Intervention> _interventions = [];
  List<Watershed> _watersheds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final intDao = ref.read(interventionDaoProvider);
    final wsDao = ref.read(watershedDaoProvider);

    final list = await intDao.getAllInterventions();
    final watersheds = await wsDao.getAllWatersheds();

    if (mounted) {
      setState(() {
        _interventions = list;
        _watersheds = watersheds;
        _isLoading = false;
      });
    }
  }

  List<Intervention> get _filteredInterventions {
    return _interventions.where((item) {
      final matchesFilter = _selectedFilter == 'all' || item.status == _selectedFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.type.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (item.contractor?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  void _showAddInterventionModal() {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final costCtrl = TextEditingController();
    final contractorCtrl = TextEditingController();
    String type = 'check_dam';
    String status = 'planned';
    String? selectedWs = _watersheds.isNotEmpty ? _watersheds.first.id : null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add New Intervention',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (_watersheds.isNotEmpty) ...[
                        const Text('Watershed Area', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: selectedWs,
                          decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                          items: _watersheds.map((w) => DropdownMenuItem(value: w.id, child: Text(w.name, style: const TextStyle(fontSize: 13)))).toList(),
                          onChanged: (val) => setModalState(() => selectedWs = val),
                        ),
                        const SizedBox(height: 12),
                      ],
                      const Text('Project Name', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(hintText: 'e.g. Loose Boulder Check Dam #3'),
                        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<String>(
                                  initialValue: type,
                                  decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                                  items: const [
                                    DropdownMenuItem(value: 'check_dam', child: Text('Check Dam')),
                                    DropdownMenuItem(value: 'percolation_tank', child: Text('Percolation Tank')),
                                    DropdownMenuItem(value: 'contour_trench', child: Text('Contour Trench')),
                                    DropdownMenuItem(value: 'farm_pond', child: Text('Farm Pond')),
                                    DropdownMenuItem(value: 'plantation', child: Text('Afforestation')),
                                  ],
                                  onChanged: (val) => setModalState(() => type = val!),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Status', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<String>(
                                  initialValue: status,
                                  decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                                  items: const [
                                    DropdownMenuItem(value: 'planned', child: Text('Planned')),
                                    DropdownMenuItem(value: 'in_progress', child: Text('In Progress')),
                                    DropdownMenuItem(value: 'completed', child: Text('Completed')),
                                  ],
                                  onChanged: (val) => setModalState(() => status = val!),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Est. Cost (₹)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: costCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(hintText: 'e.g. 250000'),
                                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Contractor / Team', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: contractorCtrl,
                                  decoration: const InputDecoration(hintText: 'e.g. Village Committee'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Description', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: descCtrl,
                        maxLines: 2,
                        decoration: const InputDecoration(hintText: 'Technical specifications, target volume...'),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) return;
                            final intDao = ref.read(interventionDaoProvider);
                            final newInt = InterventionsCompanion(
                              id: drift.Value('int_${const Uuid().v4().substring(0, 8)}'),
                              watershedId: drift.Value(selectedWs ?? 'ws_godavari_01'),
                              name: drift.Value(nameCtrl.text.trim()),
                              type: drift.Value(type),
                              status: drift.Value(status),
                              description: drift.Value(descCtrl.text.trim().isEmpty ? 'Watershed intervention project' : descCtrl.text.trim()),
                              plannedDate: drift.Value(DateTime.now()),
                              actualDate: status == 'completed' ? drift.Value(DateTime.now()) : const drift.Value(null),
                              estimatedCost: drift.Value(double.tryParse(costCtrl.text.trim()) ?? 0.0),
                              actualCost: status == 'completed' ? drift.Value(double.tryParse(costCtrl.text.trim()) ?? 0.0) : const drift.Value(null),
                              contractor: drift.Value(contractorCtrl.text.trim().isEmpty ? null : contractorCtrl.text.trim()),
                              photoIds: const drift.Value([]),
                              metadata: const drift.Value({}),
                              createdAt: drift.Value(DateTime.now()),
                              updatedAt: drift.Value(DateTime.now()),
                            );

                            await intDao.insertIntervention(newInt);
                            if (context.mounted) {
                              Navigator.pop(context);
                              _loadData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppTheme.secondaryTeal,
                                  content: Text('Intervention created successfully'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          child: const Text('Create Intervention'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watershed Interventions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Project'),
        onPressed: _showAddInterventionModal,
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search by project name, type, contractor...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () => setState(() => _searchQuery = ''),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterTab(
                        label: 'All Projects',
                        count: _interventions.length,
                        isSelected: _selectedFilter == 'all',
                        onTap: () => setState(() => _selectedFilter = 'all'),
                      ),
                      const SizedBox(width: 8),
                      _FilterTab(
                        label: 'In Progress',
                        count: _interventions.where((i) => i.status == 'in_progress').length,
                        isSelected: _selectedFilter == 'in_progress',
                        onTap: () => setState(() => _selectedFilter = 'in_progress'),
                      ),
                      const SizedBox(width: 8),
                      _FilterTab(
                        label: 'Completed',
                        count: _interventions.where((i) => i.status == 'completed').length,
                        isSelected: _selectedFilter == 'completed',
                        onTap: () => setState(() => _selectedFilter = 'completed'),
                      ),
                      const SizedBox(width: 8),
                      _FilterTab(
                        label: 'Planned',
                        count: _interventions.where((i) => i.status == 'planned').length,
                        isSelected: _selectedFilter == 'planned',
                        onTap: () => setState(() => _selectedFilter = 'planned'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          // Interventions list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredInterventions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.construction_outlined, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 12),
                            Text(
                              'No interventions found',
                              style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadData,
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                          itemCount: _filteredInterventions.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = _filteredInterventions[index];
                            final isCompleted = item.status == 'completed';
                            final isInProgress = item.status == 'in_progress';

                            Color statusColor;
                            String statusLabel;
                            if (isCompleted) {
                              statusColor = Colors.green;
                              statusLabel = 'COMPLETED';
                            } else if (isInProgress) {
                              statusColor = AppTheme.primaryBlue;
                              statusLabel = 'IN PROGRESS';
                            } else {
                              statusColor = Colors.orange;
                              statusLabel = 'PLANNED';
                            }

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: statusColor.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Icon(Icons.water, color: statusColor, size: 20),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item.type.toUpperCase().replaceAll('_', ' '),
                                                style: const TextStyle(color: AppTheme.textMuted, fontSize: 11, fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: statusColor.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                                          ),
                                          child: Text(
                                            statusLabel,
                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      item.description,
                                      style: const TextStyle(fontSize: 13, color: AppTheme.textDark, height: 1.35),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 14),
                                    Row(
                                      children: [
                                        _MetricPill(
                                          icon: Icons.currency_rupee,
                                          label: 'Est. ₹${(item.estimatedCost / 1000).toStringAsFixed(0)}k',
                                        ),
                                        const SizedBox(width: 12),
                                        if (item.contractor != null)
                                          _MetricPill(
                                            icon: Icons.engineering_outlined,
                                            label: item.contractor!.split(' ').first,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : AppTheme.borderLight,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : AppTheme.textDark,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withValues(alpha: 0.25) : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppTheme.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetricPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppTheme.textMuted),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppTheme.textMuted, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
