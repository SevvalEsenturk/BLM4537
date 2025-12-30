import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/auth_service_provider.dart';
import '../theme/app_spacing.dart';

class SettingsScreen extends ConsumerWidget {
  final int userId;
  const SettingsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hesap', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: AppSpacing.md),
            ListTile(
              title: const Text('Profili Düzenle'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to profile edit screen
              },
            ),
            Divider(),
            SizedBox(height: AppSpacing.md),
            ElevatedButton.icon(
              onPressed: () async {
                // Logout
                ref.read(authServiceProvider).logout();
                // Navigate to login
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Çıkış Yap'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
