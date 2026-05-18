import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource datasource;

  const SettingsRepositoryImpl(this.datasource);

  @override
  Future<AppSettings> getSettings() => datasource.load();

  @override
  Future<void> saveSettings(AppSettings settings) => datasource.save(settings);
}
