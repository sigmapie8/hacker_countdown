import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/countdown/countdown_bloc.dart';
import 'bloc/settings/settings_bloc.dart';
import 'bloc/settings/settings_event.dart';
import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CountdownBloc>(create: (_) => sl<CountdownBloc>()),
        BlocProvider<SettingsBloc>(
          create: (_) => sl<SettingsBloc>()..add(const SettingsStarted()),
        ),
      ],
      child: MaterialApp.router(
        title: 'hacker_countdown',
        theme: buildAppTheme(),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
