import 'package:get_it/get_it.dart';

import '../../bloc/countdown/countdown_bloc.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../data/datasources/settings_local_datasource.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton<SettingsLocalDatasource>(
    () => SettingsLocalDatasource(),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl<SettingsLocalDatasource>()),
  );
  sl.registerFactory<SettingsBloc>(
    () => SettingsBloc(sl<SettingsRepository>()),
  );
  sl.registerFactory<CountdownBloc>(() => CountdownBloc());
}
