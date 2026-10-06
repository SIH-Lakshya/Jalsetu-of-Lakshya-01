import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/auth/auth_repository.dart';
import '../../core/auth/auth_state.dart';
import '../../core/config/app_config.dart';
import '../../core/database/database_provider.dart';
import '../../core/database/database_seeder.dart';
import '../../core/models/user.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _highPrecisionGps = true;
  bool _autoSyncWifi = true;
  bool _isResetting = false;

  Future<void> _logout() async {
    await ref.read(authRepositoryProvider).logout();
    ref.read(authStateProvider.notifier).logout();
    if (mounted) context.go('/login');
  }

  Future<void> _reloadSampleData() async {
    setState(() => _isResetting = true);
    try {
      final db = ref.read(appDatabaseProvider);
      // Delete existing
      await db.delete(db.observations).go();
      await db.delete(db.interventions).go();
      await db.delete(db.watershedBoundaries).go();
      await db.delete(db.watersheds).go();
      await db.delete(db.syncQueue).go();

      await DatabaseSeeder.seedIfEmpty(db);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppTheme.secondaryTeal,
            content: Text('Sample demo data successfully reloaded!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error resetting data: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isResetting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppTheme.primaryLight,
                      child: Text(
                        (user?.name.isNotEmpty ?? false) ? user!.name[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          color: AppTheme.primaryDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Field User',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user?.email ?? 'user@jalsetu.gov.in',
                            style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              (user?.role.name ?? 'field_team').replaceAll('_', ' ').toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Role Switcher for Testing
            const Text('Switch Active Role', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  _RoleSelectionTile(
                    title: 'Field Collection Team',
                    subtitle: 'Capture observations, geo-tagged photos, offline sync',
                    isSelected: (user?.role ?? UserRole.fieldTeam) == UserRole.fieldTeam,
                    onTap: () {
                      if (user != null) {
                        ref.read(authStateProvider.notifier).login(user.copyWith(role: UserRole.fieldTeam));
                      }
                    },
                  ),
                  const Divider(height: 1),
                  _RoleSelectionTile(
                    title: 'Watershed Planner',
                    subtitle: 'GIS layers exploration, thematic overlays, time comparison',
                    isSelected: (user?.role ?? UserRole.fieldTeam) == UserRole.watershedPlanner,
                    onTap: () {
                      if (user != null) {
                        ref.read(authStateProvider.notifier).login(user.copyWith(role: UserRole.watershedPlanner));
                      }
                    },
                  ),
                  const Divider(height: 1),
                  _RoleSelectionTile(
                    title: 'Program Administrator',
                    subtitle: 'Track interventions, audit records, export monitoring reports',
                    isSelected: (user?.role ?? UserRole.fieldTeam) == UserRole.administrator,
                    onTap: () {
                      if (user != null) {
                        ref.read(authStateProvider.notifier).login(user.copyWith(role: UserRole.administrator));
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Hardware & Location Preferences
            const Text('Sensors & Geospatial Preferences', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    value: _highPrecisionGps,
                    activeTrackColor: AppTheme.primaryBlue,
                    title: const Text('High Precision GPS Mode', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Requires accuracy < 10m before locking survey point', style: TextStyle(fontSize: 12)),
                    onChanged: (val) => setState(() => _highPrecisionGps = val),
                  ),
                  const Divider(height: 1),
                  SwitchListTile.adaptive(
                    value: _autoSyncWifi,
                    activeTrackColor: AppTheme.primaryBlue,
                    title: const Text('Background Auto-Sync on Network', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Automatically upload pending items when connectivity returns', style: TextStyle(fontSize: 12)),
                    onChanged: (val) => setState(() => _autoSyncWifi = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Offline Cache & Demo Data Management
            const Text('Local Storage & Offline Database', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.storage_outlined, color: AppTheme.primaryBlue),
                    title: const Text('SQLite Storage Engine', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Drift offline-first database active', style: TextStyle(fontSize: 12)),
                    trailing: const Text('Ready', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.cloud_sync_outlined, color: AppTheme.secondaryTeal),
                    title: const Text('Backend API Service', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: Text(AppConfig.apiBaseUrl, style: const TextStyle(fontSize: 12)),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.restore, color: Colors.orange),
                    title: const Text('Reload Realistic Demo Data', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Repopulates default watersheds, boundaries, and interventions', style: TextStyle(fontSize: 12)),
                    trailing: _isResetting
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : TextButton(
                            onPressed: _reloadSampleData,
                            child: const Text('Reset'),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About Jalsetu
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.water_drop, color: AppTheme.primaryBlue, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jalsetu Watershed Platform',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Version 1.0.0 • Field & GIS Decision Support',
                            style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _logout,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.roseDanger,
                  side: const BorderSide(color: Color(0xFFFCA5A5)),
                ),
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Sign Out of Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleSelectionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleSelectionTile({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          color: isSelected ? AppTheme.primaryBlue : AppTheme.textDark,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppTheme.primaryBlue, size: 22)
          : const Icon(Icons.circle_outlined, color: AppTheme.textSubtle, size: 22),
    );
  }
}
