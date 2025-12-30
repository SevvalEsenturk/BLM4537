import 'package:riverpod/riverpod.dart';
import 'rules_service.dart';
import '../types/rule_models.dart';

final rulesServiceProvider = Provider((ref) => RulesService());

final timeRuleProvider =
    FutureProvider.family<TimeRule?, int>((ref, childId) async {
  final service = ref.watch(rulesServiceProvider);
  return service.getRule(childId);
});
