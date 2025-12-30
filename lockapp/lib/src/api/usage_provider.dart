import 'package:riverpod/riverpod.dart';
import 'usage_service.dart';
import '../types/usage_models.dart';

final usageServiceProvider = Provider((ref) => UsageService());

final usageSummaryProvider = FutureProvider.family<UsageSummary,
    ({int childId, String range})>((ref, params) async {
  final service = ref.watch(usageServiceProvider);
  return service.getUsageSummary(
    childId: params.childId,
    range: params.range,
  );
});

final topAppsProvider = FutureProvider.family<List<TopApp>,
    ({int childId, String range})>((ref, params) async {
  final service = ref.watch(usageServiceProvider);
  return service.getTopApps(
    childId: params.childId,
    range: params.range,
  );
});
