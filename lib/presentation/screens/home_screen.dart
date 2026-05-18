import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/countdown_bloc.dart';
import '../../bloc/countdown_event.dart';
import '../../bloc/countdown_state.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/control_buttons.dart';
import '../widgets/countdown_display.dart';
import '../widgets/matrix_rain_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  bool _focusMode = false;

  void _toggleFocusMode() => setState(() => _focusMode = !_focusMode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const IgnorePointer(child: MatrixRainBackground()),
          Container(color: Colors.black.withValues(alpha: 0.5)),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: _focusMode ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: IgnorePointer(
                      ignoring: _focusMode,
                      child: Text(
                        '[ HACKER COUNTDOWN ]',
                        style: AppTextStyles.headerText,
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: SizedBox(height: _focusMode ? 0 : 40),
                  ),
                  BlocBuilder<CountdownBloc, CountdownState>(
                    buildWhen:
                        (prev, curr) =>
                            prev.formattedTime != curr.formattedTime ||
                            prev.status != curr.status,
                    builder:
                        (context, state) => CountdownDisplay(
                          formattedTime: state.formattedTime,
                          status: state.status,
                          focusMode: _focusMode,
                        ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: SizedBox(height: _focusMode ? 0 : 56),
                  ),
                  AnimatedOpacity(
                    opacity: _focusMode ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: IgnorePointer(
                      ignoring: _focusMode,
                      child: BlocBuilder<CountdownBloc, CountdownState>(
                        buildWhen: (prev, curr) => prev.status != curr.status,
                        builder:
                            (context, state) => ControlButtons(
                              status: state.status,
                              onStart:
                                  () => context.read<CountdownBloc>().add(
                                    const CountdownStarted(),
                                  ),
                              onPause:
                                  () => context.read<CountdownBloc>().add(
                                    const CountdownPaused(),
                                  ),
                              onReset:
                                  () => context.read<CountdownBloc>().add(
                                    const CountdownReset(),
                                  ),
                              onRestart:
                                  () => context.read<CountdownBloc>().add(
                                    const CountdownRestarted(),
                                  ),
                              onSetDuration: () => context.go('/set-duration'),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 12,
            child: _FocusToggleButton(
              focusMode: _focusMode,
              onToggle: _toggleFocusMode,
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusToggleButton extends StatelessWidget {
  final bool focusMode;
  final VoidCallback onToggle;

  const _FocusToggleButton({required this.focusMode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: focusMode ? AppColors.neonGreen : AppColors.dimGreen,
          ),
          color: Colors.transparent,
        ),
        child: Text(
          focusMode ? '[ EXIT ]' : '[ FOCUS ]',
          style: AppTextStyles.label.copyWith(
            color: focusMode ? AppColors.neonGreen : AppColors.dimGreen,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
