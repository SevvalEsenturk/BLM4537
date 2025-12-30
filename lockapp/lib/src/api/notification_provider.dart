import 'package:riverpod/riverpod.dart';
import 'notification_service.dart';
import '../types/notification_models.dart';

final notificationServiceProvider = Provider((ref) => NotificationService());

final notificationsProvider =
    FutureProvider.family<List<NotificationItem>, int>((ref, userId) async {
  final service = ref.watch(notificationServiceProvider);
  return service.getNotifications(userId);
});
