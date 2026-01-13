import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lockapp/features/auth/data/auth_repository.dart';
import 'package:lockapp/features/settings/data/user_service.dart';
import 'package:lockapp/src/types/user_model.dart';
 // Eğer varsa, yoksa repo kullan

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  UserModel? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await ref.read(authRepositoryProvider).getCurrentUser();
    setState(() {
      _currentUser = user;
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    await ref.read(authRepositoryProvider).logout();
    if (mounted) {
      context.go('/login'); // Login rotasına git
    }
  }

  Future<void> _updateProfile() async {
    if (_currentUser == null) return;
    
    final nameController = TextEditingController(text: _currentUser!.name);
    final emailController = TextEditingController(text: _currentUser!.email);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profili Güncelle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'İsim'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final updatedUser = await ref.read(userServiceProvider).updateProfile(
                  int.parse(_currentUser!.id), // ID string mi int mi? Modelde String, Backend int. Parse et.
                  nameController.text,
                  emailController.text,
                );
                setState(() {
                  _currentUser = updatedUser;
                });
                if (mounted) Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil güncellendi')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hata: $e')),
                );
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  Future<void> _changePassword() async {
    if (_currentUser == null) return;

    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şifre Değiştir'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPassController,
              decoration: const InputDecoration(labelText: 'Eski Şifre'),
              obscureText: true,
            ),
            TextField(
              controller: newPassController,
              decoration: const InputDecoration(labelText: 'Yeni Şifre'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await ref.read(userServiceProvider).changePassword(
                  int.parse(_currentUser!.id),
                  oldPassController.text,
                  newPassController.text,
                );
                if (mounted) Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Şifre değiştirildi')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hata: $e')),
                );
              }
            },
            child: const Text('Değiştir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ayarlar')),
        body: Center(child: Text('Kullanıcı bulunamadı. Lütfen tekrar giriş yapın.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                _currentUser!.displayName.substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              _currentUser!.name,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              _currentUser!.role.value, // "Parent" or "Child"
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
            SizedBox(height: 32.h),
            
            _buildSettingsTile(
              icon: Icons.person,
              title: "Profil Bilgileri",
              subtitle: _currentUser!.email,
              onTap: _updateProfile,
            ),
            _buildSettingsTile(
              icon: Icons.lock,
              title: "Şifre Değiştir",
              subtitle: "**********",
              onTap: _changePassword,
            ),
            
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: Size(double.infinity, 50.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
