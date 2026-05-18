import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object?> get props => [];
}

class SettingsStarted extends SettingsEvent {
  const SettingsStarted();
}

class AutofocusSecondsChanged extends SettingsEvent {
  final int seconds;
  const AutofocusSecondsChanged(this.seconds);
  @override
  List<Object?> get props => [seconds];
}

class AutofocusEnabledToggled extends SettingsEvent {
  final bool enabled;
  const AutofocusEnabledToggled(this.enabled);
  @override
  List<Object?> get props => [enabled];
}
