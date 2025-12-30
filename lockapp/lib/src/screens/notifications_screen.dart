import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/notification_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  final int userId;
  const NotificationsScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Bildirimler')),
      body: notifications.when(
        data: (items) => items.isEmpty
            ? Center(
                child: Text('Bildirim yok',
                    style: Theme.of(context).textTheme.bodyMedium),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, idx) {
                  final notif = items[idx];
                  return ListTile(
                    title: Text(notif.title),
                    subtitle: Text(notif.message),
                    trailing: Text(
                      notif.createdAt.toString().split('.')[0],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    leading: notif.isRead
                        ? null
                        : const CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.blue,
                          ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Hata: $err')),
      ),
    );
  }
}
