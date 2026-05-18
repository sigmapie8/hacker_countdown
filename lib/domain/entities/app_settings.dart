import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final int autofocusSeconds;
  final bool autofocusEnabled;

  const AppSettings({
    required this.autofocusSeconds,
    required this.autofocusEnabled,
  });

  factory AppSettings.defaults() => const AppSettings(
        autofocusSeconds: 2,
        autofocusEnabled: true,
      );

  AppSettings copyWith({int? autofocusSeconds, bool? autofocusEnabled}) =>
      AppSettings(
        autofocusSeconds: autofocusSeconds ?? this.autofocusSeconds,
        autofocusEnabled: autofocusEnabled ?? this.autofocusEnabled,
      );

  @override
  List<Object?> get props => [autofocusSeconds, autofocusEnabled];
}
