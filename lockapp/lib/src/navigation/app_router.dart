import 'package:go_router/go_router.dart';

import '../constants/app_routes.dart';
import '../screens/splash/splash_screen.dart';

import '../screens/onboarding/onboarding_screen.dart';
import '../screens/onboarding/role_selection_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/parent/parent_dashboard_screen.dart';
import '../screens/parent/qr_generation_screen.dart';
import '../screens/parent/pairing_screen.dart'; // ParentPairingScreen
import '../screens/parent/rules_edit_screen.dart'; // ParentRulesEditScreen
import '../screens/parent/reports_screen.dart';
import '../screens/parent/time_restriction_screen.dart';
import '../screens/parent/usage_statistics_screen.dart';
import '../screens/child/child_dashboard_screen.dart';
import '../screens/child/qr_scanner_screen.dart';
import '../screens/child/pairing_input_screen.dart';
import '../screens/permissions/permission_screen.dart';
import '../screens/common/error_screen.dart';
import '../screens/notifications_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    // Error handling
    errorBuilder: (context, state) => ErrorScreen(
      error: state.error?.toString() ?? 'Unknown error',
    ),

    // Route definitions
    routes: [
      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding Routes
      GoRoute(
        path: AppRoutes.onboarding,
        name: AppRoutes.onboardingRouteName,
        builder: (context, state) => const OnboardingScreen(),
      ),

      GoRoute(
        path: AppRoutes.roleSelection,
        name: AppRoutes.roleSelectionRouteName,
        builder: (context, state) => const RoleSelectionScreen(),
      ),

      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginRouteName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.registerRouteName,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Parent Routes
      GoRoute(
        path: AppRoutes.parentDashboard,
        name: AppRoutes.parentDashboardRouteName,
        builder: (context, state) => const ParentDashboardScreen(),
      ),

      // QR Generation Route (Parent)
      GoRoute(
        path: AppRoutes.qrGeneration,
        name: AppRoutes.qrGenerationRouteName,
        builder: (context, state) => const QrGenerationScreen(),
      ),

      // Parent - Pairing
      GoRoute(
        path: AppRoutes.parentPairing,
        name: AppRoutes.parentPairingRouteName,
        builder: (context, state) {
          final parentId =
              int.parse(state.uri.queryParameters['parentId'] ?? '0');
          return ParentPairingScreen(parentId: parentId);
        },
      ),

      // Parent - Rules
      GoRoute(
        path: AppRoutes.parentRules,
        name: AppRoutes.parentRulesRouteName,
        builder: (context, state) {
          final childId =
              int.parse(state.uri.queryParameters['childId'] ?? '0');
          return ParentRulesEditScreen(childId: childId);
        },
      ),

      // Parent - Time Restriction
      GoRoute(
        path: AppRoutes.timeRestriction,
        name: AppRoutes.timeRestrictionRouteName,
        builder: (context, state) => const TimeRestrictionScreen(),
      ),

      // Parent - Reports
      GoRoute(
        path: AppRoutes.parentReports,
        name: AppRoutes.parentReportsRouteName,
        builder: (context, state) {
          final childId =
              int.parse(state.uri.queryParameters['childId'] ?? '0');
          return ReportsScreen(childId: childId);
        },
      ),

      // Parent - Usage Statistics
      GoRoute(
        path: AppRoutes.usageStats,
        name: AppRoutes.usageStatsRouteName,
        builder: (context, state) => const UsageStatisticsScreen(),
      ),

      // Child Routes
      GoRoute(
        path: AppRoutes.childDashboard,
        name: AppRoutes.childDashboardRouteName,
        builder: (context, state) => const ChildDashboardScreen(),
      ),

      // QR Scanner Route (Child)
      GoRoute(
        path: AppRoutes.qrScanner,
        name: AppRoutes.qrScannerRouteName,
        builder: (context, state) => const QrScannerScreen(),
      ),

      // Child - Pairing Input
      GoRoute(
        path: AppRoutes.childPairing,
        name: AppRoutes.childPairingRouteName,
        builder: (context, state) {
          final childUserId =
              int.parse(state.uri.queryParameters['childUserId'] ?? '0');
          final parentUserId =
              int.parse(state.uri.queryParameters['parentUserId'] ?? '0');
          return ChildPairingInputScreen(
              childUserId: childUserId, parentUserId: parentUserId);
        },
      ),

      // Notifications (Common)
      GoRoute(
        path: AppRoutes.notifications,
        name: AppRoutes.notificationsRouteName,
        builder: (context, state) {
          final userId = int.parse(state.uri.queryParameters['userId'] ?? '0');
          return NotificationsScreen(userId: userId);
        },
      ),

      // Permission Routes
      GoRoute(
        path: AppRoutes.permissions,
        name: AppRoutes.permissionsRouteName,
        builder: (context, state) => const PermissionScreen(),
      ),

      // Error Route
      GoRoute(
        path: AppRoutes.error,
        name: AppRoutes.errorRouteName,
        builder: (context, state) => ErrorScreen(
          error: state.uri.queryParameters['message'] ?? 'Unknown error',
        ),
      ),

      // Settings Route
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settingsRouteName,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],

    // Route redirect logic
    redirect: (context, state) {
      // TODO: Implement authentication and role-based redirects
      // For now, we'll handle basic routing

      // final isOnSplash = state.matchedLocation == AppRoutes.splash;
      // final isOnAuth = AppRoutes.isAuthRoute(state.matchedLocation);
      // final isOnOnboarding = state.matchedLocation == AppRoutes.onboarding ||
      //                       state.matchedLocation == AppRoutes.roleSelection;

      // TODO: Check if user is authenticated
      // final isAuthenticated = await checkUserAuthentication();

      // TODO: Check if user has completed onboarding
      // final hasCompletedOnboarding = await checkOnboardingStatus();

      // TODO: Get user role
      // final userRole = await getUserRole();

      // For now, allow all routes
      return null;
    },
  );

  // Navigation helper methods

  static void goToOnboarding() {
    router.goNamed(AppRoutes.onboardingRouteName);
  }

  static void goToRoleSelection() {
    router.goNamed(AppRoutes.roleSelectionRouteName);
  }

  static void goToParentDashboard() {
    router.goNamed(AppRoutes.parentDashboardRouteName);
  }

  static void goToQrGeneration() {
    router.goNamed(AppRoutes.qrGenerationRouteName);
  }

  static void goToChildDashboard() {
    router.goNamed(AppRoutes.childDashboardRouteName);
  }

  static void goToQrScanner() {
    router.goNamed(AppRoutes.qrScannerRouteName);
  }

  static void goToPermissions() {
    router.goNamed(AppRoutes.permissionsRouteName);
  }

  static void goToSettings() {
    router.pushNamed(AppRoutes.settingsRouteName);
  }

  static void goToError(String message) {
    router.goNamed(
      AppRoutes.errorRouteName,
      queryParameters: {'message': message},
    );
  }

  // Parent navigation helpers
  static void goToParentPairing() {
    router.pushNamed(AppRoutes.parentPairingRouteName);
  }

  static void goToParentRules(int childId) {
    router.pushNamed(
      AppRoutes.parentRulesRouteName,
      queryParameters: {'childId': childId.toString()},
    );
  }

  static void goToTimeRestriction() {
    router.pushNamed(AppRoutes.timeRestrictionRouteName);
  }

  static void goToParentReports() {
    router.pushNamed(AppRoutes.parentReportsRouteName);
  }

  static void goToUsageStatistics() {
    router.pushNamed(AppRoutes.usageStatsRouteName);
  }

  // Child navigation helpers
  static void goToChildPairing() {
    router.pushNamed(AppRoutes.childPairingRouteName);
  }

  // Common navigation helpers
  static void goToNotifications(int userId) {
    router.pushNamed(
      AppRoutes.notificationsRouteName,
      queryParameters: {'userId': userId.toString()},
    );
  }

  // Note: Use Navigator.of(context).pop() instead of router.pop()
  // for better context-aware navigation
}
