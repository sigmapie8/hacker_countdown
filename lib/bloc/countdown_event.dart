import 'package:equatable/equatable.dart';

abstract class CountdownEvent extends Equatable {
  const CountdownEvent();
}

class CountdownDurationSet extends CountdownEvent {
  final Duration duration;
  const CountdownDurationSet(this.duration);
  @override
  List<Object?> get props => [duration];
}

class CountdownStarted extends CountdownEvent {
  const CountdownStarted();
  @override
  List<Object?> get props => [];
}

class CountdownPaused extends CountdownEvent {
  const CountdownPaused();
  @override
  List<Object?> get props => [];
}

class CountdownReset extends CountdownEvent {
  const CountdownReset();
  @override
  List<Object?> get props => [];
}

class CountdownRestarted extends CountdownEvent {
  const CountdownRestarted();
  @override
  List<Object?> get props => [];
}

class CountdownTicked extends CountdownEvent {
  const CountdownTicked();
  @override
  List<Object?> get props => [];
}

class CountdownLifecycleResumed extends CountdownEvent {
  final DateTime resumedAt;
  const CountdownLifecycleResumed(this.resumedAt);
  @override
  List<Object?> get props => [resumedAt];
}
