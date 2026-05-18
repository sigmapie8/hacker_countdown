import 'package:flutter/material.dart';

import '../../bloc/countdown_state.dart';
import '../../core/theme/app_theme.dart';

class CountdownDisplay extends StatelessWidget {
  final String formattedTime;
  final TimerStatus status;
  final bool focusMode;

  const CountdownDisplay({
    super.key,
    required this.formattedTime,
    required this.status,
    this.focusMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = status == TimerStatus.finished
        ? const Color(0xFFFF4141)
        : AppColors.neonGreen;

    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: AppTextStyles.timerDisplay.copyWith(
        color: color,
        fontSize: focusMode ? 96 : 64,
      ),
      child: Text(
        formattedTime,
        textAlign: TextAlign.center,
      ),
    );
  }
}
