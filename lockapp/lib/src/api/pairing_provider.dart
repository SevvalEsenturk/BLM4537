import 'package:riverpod/riverpod.dart';
import 'pairing_service.dart';
import '../types/pairing_models.dart';

final pairingServiceProvider = Provider((ref) => PairingService());

final pendingPairingRequestsProvider =
    FutureProvider.family<List<PairingRequest>, int>((ref, parentId) async {
  final service = ref.watch(pairingServiceProvider);
  return service.getPendingRequests(parentId);
});

final pairingCodeProvider =
    FutureProvider.family<PairingCode, int>((ref, parentId) async {
  final service = ref.watch(pairingServiceProvider);
  return service.createCode(parentId);
});
