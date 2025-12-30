import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

@freezed
class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    required int id,
    required String title,
    required String message,
    required String type,
    required bool isRead,
    required DateTime createdAt,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}
