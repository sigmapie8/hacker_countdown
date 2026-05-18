import 'package:equatable/equatable.dart';

enum TimerStatus { initial, running, paused, finished }

class CountdownState extends Equatable {
  final Duration remaining;
  final Duration initialDuration;
  final TimerStatus status;

  const CountdownState({
    required this.remaining,
    required this.initialDuration,
    required this.status,
  });

  factory CountdownState.initial() => const CountdownState(
        remaining: Duration.zero,
        initialDuration: Duration.zero,
        status: TimerStatus.initial,
      );

  String get formattedTime {
    final s = remaining.inSeconds.clamp(0, double.maxFinite.toInt());
    final h = s ~/ 3600;
    final m = (s % 3600) ~/ 60;
    final sec = s % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${sec.toString().padLeft(2, '0')}';
  }

  CountdownState copyWith({
    Duration? remaining,
    Duration? initialDuration,
    TimerStatus? status,
  }) =>
      CountdownState(
        remaining: remaining ?? this.remaining,
        initialDuration: initialDuration ?? this.initialDuration,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [remaining, initialDuration, status];
}
