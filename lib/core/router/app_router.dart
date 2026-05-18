import 'package:go_router/go_router.dart';

import '../../presentation/countdown/screens/home_screen.dart';
import '../../presentation/countdown/screens/set_duration_screen.dart';
import '../../presentation/settings/screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/set-duration',
      name: 'set-duration',
      builder: (context, state) => const SetDurationScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
