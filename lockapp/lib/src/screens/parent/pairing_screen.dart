import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/pairing_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_spacing.dart';

class ParentPairingScreen extends ConsumerStatefulWidget {
  final int parentId;
  const ParentPairingScreen({Key? key, required this.parentId})
      : super(key: key);

  @override
  ConsumerState<ParentPairingScreen> createState() =>
      _ParentPairingScreenState();
}

class _ParentPairingScreenState extends ConsumerState<ParentPairingScreen> {
  @override
  Widget build(BuildContext context) {
    final pendingRequests =
        ref.watch(pendingPairingRequestsProvider(widget.parentId));
    final pairingCode = ref.watch(pairingCodeProvider(widget.parentId));

    return Scaffold(
      appBar: AppBar(title: const Text('Eşleştirme Talepleri')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('QR Kod Oluştur', style: AppTextStyles.headline5),
              SizedBox(height: AppSpacing.md),
              pairingCode.when(
                data: (code) => Container(
                  padding: EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyLight),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(code.code, style: AppTextStyles.headline3),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'Süresi: ${code.expiresAt.difference(DateTime.now()).inMinutes} dakika',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Hata: $err'),
              ),
              SizedBox(height: AppSpacing.xl),
              Text('Bekleyen İstekler', style: AppTextStyles.headline5),
              SizedBox(height: AppSpacing.md),
              pendingRequests.when(
                data: (requests) => requests.isEmpty
                    ? Center(
                        child: Text(
                          'Bekleyen istek yok',
                          style: AppTextStyles.bodyMedium,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final req = requests[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: AppSpacing.md),
                            child: ListTile(
                              title: Text(req.childName ?? 'Bilinmiyor'),
                              subtitle: Text(
                                '${req.deviceName} (${req.deviceType})',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.check,
                                        color: Colors.green),
                                    onPressed: () async {
                                      try {
                                        await ref
                                          .read(pairingServiceProvider)
                                          .approvePairingRequest(req.id);
                                        final _ = ref.refresh(
                                          pendingPairingRequestsProvider(
                                            widget.parentId));
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text('Hata: $e')),
                                        );
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        color: Colors.red),
                                    onPressed: () async {
                                      try {
                                        await ref
                                          .read(pairingServiceProvider)
                                          .rejectPairingRequest(req.id);
                                        final _ = ref.refresh(
                                          pendingPairingRequestsProvider(
                                            widget.parentId));
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text('Hata: $e')),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Hata: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
