import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/countdown_bloc.dart';
import '../../bloc/countdown_event.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/duration_input.dart';

class SetDurationScreen extends StatefulWidget {
  const SetDurationScreen({super.key});

  @override
  State<SetDurationScreen> createState() => _SetDurationScreenState();
}

class _SetDurationScreenState extends State<SetDurationScreen> {
  Duration _selected = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('[ SET DURATION ]'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.neonGreen),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ENTER COUNTDOWN DURATION', style: AppTextStyles.label),
              const SizedBox(height: 40),
              DurationInput(
                initialValue: _selected,
                onChanged: (d) => setState(() => _selected = d),
              ),
              const SizedBox(height: 48),
              OutlinedButton(
                onPressed: () {
                  if (_selected.inSeconds <= 0) return;
                  context.read<CountdownBloc>().add(
                        CountdownDurationSet(_selected),
                      );
                  context.go('/');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.neonGreen,
                  side: const BorderSide(color: AppColors.neonGreen),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  textStyle: AppTextStyles.buttonText,
                ),
                child: const Text('[ CONFIRM ]'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
