import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc(this._repository) : super(SettingsState.initial()) {
    on<SettingsStarted>(_onStarted);
    on<AutofocusSecondsChanged>(_onSecondsChanged);
    on<AutofocusEnabledToggled>(_onEnabledToggled);
  }

  Future<void> _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async {
    final settings = await _repository.getSettings();
    emit(state.copyWith(settings: settings, isLoading: false));
  }

  Future<void> _onSecondsChanged(
    AutofocusSecondsChanged event,
    Emitter<SettingsState> emit,
  ) async {
    final updated = state.settings.copyWith(autofocusSeconds: event.seconds);
    emit(state.copyWith(settings: updated));
    await _repository.saveSettings(updated);
  }

  Future<void> _onEnabledToggled(
    AutofocusEnabledToggled event,
    Emitter<SettingsState> emit,
  ) async {
    final updated = state.settings.copyWith(autofocusEnabled: event.enabled);
    emit(state.copyWith(settings: updated));
    await _repository.saveSettings(updated);
  }
}
