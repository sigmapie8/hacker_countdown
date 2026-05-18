import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'countdown_event.dart';
import 'countdown_state.dart';

class CountdownBloc extends Bloc<CountdownEvent, CountdownState>
    with WidgetsBindingObserver {
  Timer? _ticker;
  DateTime? _backgroundedAt;

  CountdownBloc() : super(CountdownState.initial()) {
    WidgetsBinding.instance.addObserver(this);
    on<CountdownDurationSet>(_onDurationSet);
    on<CountdownStarted>(_onStarted);
    on<CountdownPaused>(_onPaused);
    on<CountdownReset>(_onReset);
    on<CountdownRestarted>(_onRestarted);
    on<CountdownTicked>(_onTicked);
    on<CountdownLifecycleResumed>(_onLifecycleResumed);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused &&
        this.state.status == TimerStatus.running) {
      _backgroundedAt = DateTime.now();
      _cancelTicker();
    } else if (state == AppLifecycleState.resumed &&
        _backgroundedAt != null) {
      add(CountdownLifecycleResumed(DateTime.now()));
    }
  }

  void _startTicker() {
    _cancelTicker();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isClosed) add(const CountdownTicked());
    });
  }

  void _cancelTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  void _onDurationSet(
      CountdownDurationSet event, Emitter<CountdownState> emit) {
    _cancelTicker();
    emit(state.copyWith(
      remaining: event.duration,
      initialDuration: event.duration,
      status: TimerStatus.initial,
    ));
  }

  void _onStarted(CountdownStarted event, Emitter<CountdownState> emit) {
    if (state.remaining.inSeconds <= 0) return;
    emit(state.copyWith(status: TimerStatus.running));
    _startTicker();
  }

  void _onPaused(CountdownPaused event, Emitter<CountdownState> emit) {
    if (state.status != TimerStatus.running) return;
    _cancelTicker();
    emit(state.copyWith(status: TimerStatus.paused));
  }

  void _onReset(CountdownReset event, Emitter<CountdownState> emit) {
    _cancelTicker();
    _backgroundedAt = null;
    emit(state.copyWith(
      remaining: state.initialDuration,
      status: TimerStatus.initial,
    ));
  }

  void _onRestarted(CountdownRestarted event, Emitter<CountdownState> emit) {
    _cancelTicker();
    _backgroundedAt = null;
    emit(state.copyWith(
      remaining: state.initialDuration,
      status: TimerStatus.running,
    ));
    _startTicker();
  }

  void _onTicked(CountdownTicked event, Emitter<CountdownState> emit) {
    if (state.status != TimerStatus.running) return;
    final next = state.remaining - const Duration(seconds: 1);
    if (next.inSeconds <= 0) {
      _cancelTicker();
      emit(state.copyWith(
        remaining: Duration.zero,
        status: TimerStatus.finished,
      ));
    } else {
      emit(state.copyWith(remaining: next));
    }
  }

  void _onLifecycleResumed(
      CountdownLifecycleResumed event, Emitter<CountdownState> emit) {
    if (_backgroundedAt == null) return;
    final elapsed = event.resumedAt.difference(_backgroundedAt!);
    _backgroundedAt = null;
    final corrected = state.remaining - elapsed;
    if (corrected.inSeconds <= 0) {
      emit(state.copyWith(
          remaining: Duration.zero, status: TimerStatus.finished));
    } else {
      emit(state.copyWith(remaining: corrected, status: TimerStatus.running));
      _startTicker();
    }
  }

  @override
  Future<void> close() {
    _cancelTicker();
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
