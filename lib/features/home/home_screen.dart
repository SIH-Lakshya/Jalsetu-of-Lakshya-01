import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/auth/auth_state.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/sync/sync_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _pendingSyncCount = 0;
  List<Observation> _recentObservations = [];
  int _totalInterventions = 0;
  String _activeWatershedName = 'Upper Godavari Catchment Block-7';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    final syncDao = ref.read(syncQueueDaoProvider);
    final obsDao = ref.read(observationDaoProvider);
    final intDao = ref.read(interventionDaoProvider);
    final wsDao = ref.read(watershedDaoProvider);

    final pending = await syncDao.getPendingCount();
    final observations = await obsDao.getAllObservations();
    final interventions = await intDao.getAllInterventions();
    final watersheds = await wsDao.getAllWatersheds();

    if (mounted) {
      setState(() {
        _pendingSyncCount = pending;
        _recentObservations = observations.reversed.take(4).toList();
        _totalInterventions = interventions.length;
        if (watersheds.isNotEmpty) {
          _activeWatershedName = watersheds.first.name;
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    await ref.read(syncServiceProvider).syncAll();
    await _loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jalsetu Dashboard',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            Row(
              children: [
                const Icon(Icons.terrain, size: 12, color: AppTheme.secondaryTeal),
                const SizedBox(width: 4),
                Text(
                  _activeWatershedName,
                  style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (_pendingSyncCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: ActionChip(
                backgroundColor: const Color(0xFFFEF3C7),
                avatar: const Icon(Icons.cloud_upload_outlined, size: 14, color: Color(0xFFD97706)),
                label: Text(
                  '$_pendingSyncCount Pending',
                  style: const TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.bold, fontSize: 11),
                ),
                onPressed: () => context.push('/sync'),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Profile',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        backgroundColor: Colors.white,
        elevation: 2,
        indicatorColor: AppTheme.primaryLight,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              break; // Already on dashboard
            case 1:
              context.push('/map');
              break;
            case 2:
              context.push('/interventions');
              break;
            case 3:
              context.push('/sync');
              break;
            case 4:
              context.push('/reports');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard, color: AppTheme.primaryBlue),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map, color: AppTheme.primaryBlue),
            label: 'Map GIS',
          ),
          NavigationDestination(
            icon: Icon(Icons.construction_outlined),
            selectedIcon: Icon(Icons.construction, color: AppTheme.primaryBlue),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(Icons.sync),
            selectedIcon: Icon(Icons.sync, color: AppTheme.primaryBlue),
            label: 'Sync',
          ),
          NavigationDestination(
            icon: Icon(Icons.assessment_outlined),
            selectedIcon: Icon(Icons.assessment, color: AppTheme.primaryBlue),
            label: 'Reports',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User greeting card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: AppTheme.primaryLight,
                              child: Text(
                                (user?.name.isNotEmpty ?? false) ? user!.name[0].toUpperCase() : 'F',
                                style: const TextStyle(
                                  color: AppTheme.primaryDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome, ${user?.name ?? 'Field Surveyor'}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    (user?.role.name ?? 'field_team').replaceAll('_', ' ').toUpperCase(),
                                    style: const TextStyle(
                                      color: AppTheme.primaryBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.green[200]!),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.circle, color: Colors.green, size: 8),
                                  SizedBox(width: 6),
                                  Text(
                                    'Ready',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Metric Cards Row
                    Row(
                      children: [
                        Expanded(
                          child: _MetricCard(
                            label: 'Observations',
                            value: '${_recentObservations.length}',
                            subtitle: 'Field points recorded',
                            color: AppTheme.primaryBlue,
                            icon: Icons.place_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MetricCard(
                            label: 'Interventions',
                            value: '$_totalInterventions',
                            subtitle: 'Active watershed projects',
                            color: AppTheme.secondaryTeal,
                            icon: Icons.water_drop_outlined,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Quick Actions Bento Grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quick Actions',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        TextButton(
                          onPressed: () => context.push('/map'),
                          child: const Text('Open Map', style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.25,
                      children: [
                        _BentoActionCard(
                          icon: Icons.add_location_alt_rounded,
                          title: 'New Observation',
                          subtitle: 'Capture GPS & Photos',
                          iconBgColor: AppTheme.primaryLight,
                          iconColor: AppTheme.primaryBlue,
                          onTap: () async {
                            await context.push('/observations/new');
                            _loadDashboardData();
                          },
                        ),
                        _BentoActionCard(
                          icon: Icons.map_rounded,
                          title: 'Watershed GIS',
                          subtitle: 'Boundary & Overlays',
                          iconBgColor: const Color(0xFFCCFBF1),
                          iconColor: AppTheme.secondaryTeal,
                          onTap: () => context.push('/map'),
                        ),
                        _BentoActionCard(
                          icon: Icons.construction_rounded,
                          title: 'Interventions',
                          subtitle: 'Check Dams & Bunds',
                          iconBgColor: const Color(0xFFFEF3C7),
                          iconColor: const Color(0xFFD97706),
                          onTap: () => context.push('/interventions'),
                        ),
                        _BentoActionCard(
                          icon: Icons.cloud_sync_rounded,
                          title: 'Sync Manager',
                          subtitle: _pendingSyncCount > 0 ? '$_pendingSyncCount in Queue' : 'Up to Date',
                          iconBgColor: _pendingSyncCount > 0 ? const Color(0xFFFFEDD5) : const Color(0xFFF1F5F9),
                          iconColor: _pendingSyncCount > 0 ? Colors.orange[800]! : Colors.grey[700]!,
                          onTap: () async {
                            await context.push('/sync');
                            _loadDashboardData();
                          },
                        ),
                        _BentoActionCard(
                          icon: Icons.assessment_rounded,
                          title: 'Reports & Analytics',
                          subtitle: 'Summary & Export',
                          iconBgColor: const Color(0xFFF3E8FF),
                          iconColor: Colors.purple[700]!,
                          onTap: () => context.push('/reports'),
                        ),
                        _BentoActionCard(
                          icon: Icons.tune_rounded,
                          title: 'Settings & Cache',
                          subtitle: 'Roles & Preferences',
                          iconBgColor: const Color(0xFFF1F5F9),
                          iconColor: AppTheme.textDark,
                          onTap: () => context.push('/settings'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Recent Observations Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Observations',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        TextButton(
                          onPressed: () => context.push('/map'),
                          child: const Text('View All', style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (_recentObservations.isEmpty)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.add_location_outlined, size: 36, color: Colors.grey[400]),
                                const SizedBox(height: 8),
                                const Text(
                                  'No observations recorded yet',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tap "New Observation" to capture your first survey point.',
                                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _recentObservations.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final obs = _recentObservations[index];
                          final isSynced = obs.status == 'synced';
                          return Card(
                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryLight,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.water_drop, color: AppTheme.primaryBlue, size: 20),
                              ),
                              title: Text(
                                obs.type.toUpperCase().replaceAll('_', ' '),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              subtitle: Text(
                                obs.notes ?? 'Coordinates: ${obs.latitude.toStringAsFixed(3)}, ${obs.longitude.toStringAsFixed(3)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isSynced ? Colors.green[50] : Colors.amber[50],
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isSynced ? Colors.green[200]! : Colors.amber[200]!,
                                  ),
                                ),
                                child: Text(
                                  obs.status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isSynced ? Colors.green[800] : Colors.amber[800],
                                  ),
                                ),
                              ),
                              onTap: () => context.push('/map'),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.subtitle,
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
                Text(
                  label,
                  style: const TextStyle(fontSize: 13, color: AppTheme.textMuted, fontWeight: FontWeight.w600),
                ),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _BentoActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _BentoActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
