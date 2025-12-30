import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api/usage_provider.dart';
import '../../theme/app_spacing.dart';

class ReportsScreen extends ConsumerWidget {
  final int childId;
  const ReportsScreen({Key? key, required this.childId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary =
        ref.watch(usageSummaryProvider((childId: childId, range: 'daily')));
    final topApps =
        ref.watch(topAppsProvider((childId: childId, range: 'daily')));

    return Scaffold(
      appBar: AppBar(title: const Text('Kullanım Raporu')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Günlük Özet', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: AppSpacing.md),
              summary.when(
                data: (data) => Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Toplam Kullanım: ${data.totalMinutes} dakika',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          'Tarih: ${data.startDate.toString().split(' ')[0]}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => Text('Hata: $err'),
              ),
              SizedBox(height: AppSpacing.lg),
              Text('En Çok Kullanılan Uygulamalar',
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: AppSpacing.md),
              topApps.when(
                data: (apps) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: apps.length,
                  itemBuilder: (context, idx) {
                    final app = apps[idx];
                    return ListTile(
                      title: Text(app.appName),
                      subtitle: Text(app.category ?? 'N/A'),
                      trailing: Text('${app.totalMinutes} dk'),
                    );
                  },
                ),
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => Text('Hata: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
