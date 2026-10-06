import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/database/database_provider.dart';
import '../../core/sync/sync_service.dart';

class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  bool _isSyncing = false;
  bool _isOnline = true;
  List<SyncQueueData> _queueItems = [];
  int _pendingCount = 0;
  int _syncedCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _loadSyncData();
  }

  Future<void> _checkConnectivity() async {
    final results = await Connectivity().checkConnectivity();
    if (mounted) {
      setState(() {
        _isOnline = !results.contains(ConnectivityResult.none);
      });
    }
  }

  Future<void> _loadSyncData() async {
    setState(() => _isLoading = true);
    final syncDao = ref.read(syncQueueDaoProvider);
    final obsDao = ref.read(observationDaoProvider);

    final queue = await syncDao.getAllItems();
    final allObs = await obsDao.getAllObservations();

    final pending = queue.where((i) => i.status == 'pending').length;
    final synced = allObs.where((o) => o.status == 'synced').length;

    if (mounted) {
      setState(() {
        _queueItems = queue;
        _pendingCount = pending;
        _syncedCount = synced;
        _isLoading = false;
      });
    }
  }

  Future<void> _performSync() async {
    setState(() => _isSyncing = true);
    try {
      await ref.read(syncServiceProvider).syncAll();
      await _loadSyncData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppTheme.secondaryTeal,
            content: Text('All pending data successfully synchronized!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sync note: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Sync Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSyncData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadSyncData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Connection Status Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: _isOnline ? Colors.green[50] : Colors.amber[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isOnline ? Colors.green[200]! : Colors.amber[200]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isOnline ? Icons.cloud_done : Icons.cloud_off,
                            color: _isOnline ? Colors.green[700] : Colors.amber[800],
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _isOnline ? 'Online (Ready to Sync)' : 'Offline (Field Mode Active)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: _isOnline ? Colors.green[800] : Colors.amber[900],
                                  ),
                                ),
                                Text(
                                  _isOnline
                                      ? 'All modifications can be uploaded to server.'
                                      : 'Records are securely persisted in local SQLite database.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _isOnline ? Colors.green[700] : Colors.amber[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Metrics row
                    Row(
                      children: [
                        Expanded(
                          child: _SyncStatCard(
                            label: 'Pending Sync',
                            count: '$_pendingCount',
                            color: _pendingCount > 0 ? Colors.orange : Colors.grey,
                            icon: Icons.upload_file_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SyncStatCard(
                            label: 'Synced Records',
                            count: '$_syncedCount',
                            color: Colors.green,
                            icon: Icons.check_circle_outline,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: _SyncStatCard(
                            label: 'Failed / Retries',
                            count: '0',
                            color: Colors.blue,
                            icon: Icons.autorenew,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Sync Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isSyncing ? null : _performSync,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        icon: _isSyncing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Icon(Icons.sync, size: 22),
                        label: Text(
                          _isSyncing
                              ? 'Synchronizing...'
                              : _pendingCount > 0
                                  ? 'Sync $_pendingCount Pending Records Now'
                                  : 'Force Refresh & Verify Sync',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Sync Queue Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Synchronization Queue',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        if (_queueItems.isNotEmpty)
                          Text(
                            '${_queueItems.length} items',
                            style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (_queueItems.isEmpty)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(Icons.done_all, color: Colors.green, size: 40),
                                const SizedBox(height: 12),
                                const Text(
                                  'Queue is completely clear!',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'All field observations and photos are synced.',
                                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
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
                        itemCount: _queueItems.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = _queueItems[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppTheme.primaryLight,
                                child: const Icon(Icons.upload, color: AppTheme.primaryBlue, size: 20),
                              ),
                              title: Text(
                                '${item.entityType.toUpperCase()} #${item.entityId.replaceAll(RegExp(r'[^0-9]'), '')}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              subtitle: Text(
                                'Operation: ${item.operation} • Retries: ${item.retryCount}',
                                style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                              ),
                              trailing: Chip(
                                label: Text(item.status.toUpperCase()),
                                backgroundColor: item.status == 'pending' ? Colors.orange[50] : Colors.green[50],
                                labelStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: item.status == 'pending' ? Colors.orange[800] : Colors.green[800],
                                ),
                              ),
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

class _SyncStatCard extends StatelessWidget {
  final String label;
  final String count;
  final Color color;
  final IconData icon;

  const _SyncStatCard({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppTheme.textMuted, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
