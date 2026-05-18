import 'package:flutter/material.dart';

import '../../../bloc/countdown/countdown_state.dart';
import '../../../core/theme/app_theme.dart';

class ControlButtons extends StatelessWidget {
  final TimerStatus status;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;
  final VoidCallback onRestart;
  final VoidCallback onSetDuration;

  const ControlButtons({
    super.key,
    required this.status,
    required this.onStart,
    required this.onPause,
    required this.onReset,
    required this.onRestart,
    required this.onSetDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (status == TimerStatus.finished)
              _HackerButton(label: '[ RESTART ]', onPressed: onRestart),
            if (status != TimerStatus.finished) ...[
              if (status == TimerStatus.initial || status == TimerStatus.paused)
                _HackerButton(
                  label: status == TimerStatus.paused ? '[ RESUME ]' : '[ START ]',
                  onPressed: onStart,
                ),
              if (status == TimerStatus.running)
                _HackerButton(label: '[ PAUSE ]', onPressed: onPause),
              const SizedBox(width: 16),
              _HackerButton(
                label: '[ RESET ]',
                onPressed: onReset,
                secondary: true,
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        _HackerButton(
          label: '[ SET DURATION ]',
          onPressed: onSetDuration,
          secondary: true,
        ),
      ],
    );
  }
}

class _HackerButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool secondary;

  const _HackerButton({
    required this.label,
    required this.onPressed,
    this.secondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = secondary ? AppColors.dimGreen : AppColors.neonGreen;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: effectiveColor,
        side: BorderSide(color: effectiveColor),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: AppTextStyles.buttonText.copyWith(color: effectiveColor),
      ),
      child: Text(label),
    );
  }
}
