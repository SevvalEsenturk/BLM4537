import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/rules_provider.dart';
import '../../theme/app_spacing.dart';

class ParentRulesEditScreen extends ConsumerStatefulWidget {
  final int childId;
  const ParentRulesEditScreen({Key? key, required this.childId})
      : super(key: key);

  @override
  ConsumerState<ParentRulesEditScreen> createState() =>
      _ParentRulesEditScreenState();
}

class _ParentRulesEditScreenState extends ConsumerState<ParentRulesEditScreen> {
  late TextEditingController _limitController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _limitController = TextEditingController(text: '120');
  }

  @override
  Widget build(BuildContext context) {
    final rule = ref.watch(timeRuleProvider(widget.childId));

    return Scaffold(
      appBar: AppBar(title: const Text('Kural Düzenle')),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Günlük Limit (dakika)', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _limitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '120',
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
                              .read(rulesServiceProvider)
                              .upsertRule(
                                childId: widget.childId,
                                dailyLimitMinutes:
                                    int.parse(_limitController.text),
                              );
                          final _ = ref.refresh(timeRuleProvider(widget.childId));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kural kaydedildi')),
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
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Kaydet'),
              ),
            ),
            SizedBox(height: AppSpacing.lg),
            rule.when(
              data: (data) => data != null
                  ? Text(
                      'Mevcut Limit: ${data.dailyLimitMinutes} dakika',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : Text('Henüz kural belirlenmedi'),
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text('Hata: $err'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _limitController.dispose();
    super.dispose();
  }
}
