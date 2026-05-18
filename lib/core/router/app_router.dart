import 'package:go_router/go_router.dart';

import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/set_duration_screen.dart';

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
  ],
);
