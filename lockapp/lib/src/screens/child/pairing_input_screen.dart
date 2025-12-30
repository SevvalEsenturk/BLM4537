import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/pairing_provider.dart';
import '../../theme/app_spacing.dart';

class ChildPairingInputScreen extends ConsumerStatefulWidget {
  final int childUserId;
  final int parentUserId;
  const ChildPairingInputScreen({
    Key? key,
    required this.childUserId,
    required this.parentUserId,
  }) : super(key: key);

  @override
  ConsumerState<ChildPairingInputScreen> createState() =>
      _ChildPairingInputScreenState();
}

class _ChildPairingInputScreenState extends ConsumerState<ChildPairingInputScreen> {
  final _codeController = TextEditingController();
  final _deviceNameController = TextEditingController(text: 'Web Device');
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kodu Gir')),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Eşleştirme Kodu',
                hintText: 'Ebeveynden aldığınız kodu girin',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.characters,
            ),
            SizedBox(height: AppSpacing.md),
            TextField(
              controller: _deviceNameController,
              decoration: InputDecoration(
                labelText: 'Cihaz Adı',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() => _isLoading = true);
                        try {
                          await ref
                              .read(pairingServiceProvider)
                              .submitPairingRequest(
                                parentUserId: widget.parentUserId,
                                childUserId: widget.childUserId,
                                code: _codeController.text.trim(),
                                deviceName:
                                    _deviceNameController.text.trim(),
                                deviceType: 'web',
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Talep gönderildi. Ebeveynin onayını bekleyin.'),
                            ),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Hata: $e')),
                          );
                        } finally {
                          setState(() => _isLoading = false);
                        }
                      },
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Talep Gönder'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _deviceNameController.dispose();
    super.dispose();
  }
}
