import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/settings/settings_bloc.dart';
import '../../../bloc/settings/settings_event.dart';
import '../../../core/theme/app_theme.dart';
import '../../shared/widgets/matrix_rain_background.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _secondsController;
  late bool _pendingEnabled;

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsBloc>().state.settings;
    _pendingEnabled = settings.autofocusEnabled;
    _secondsController = TextEditingController(
      text: settings.autofocusSeconds.toString(),
    );
  }

  @override
  void dispose() {
    _secondsController.dispose();
    super.dispose();
  }

  void _save() {
    final parsed = int.tryParse(_secondsController.text);
    final seconds = (parsed != null && parsed > 0)
        ? parsed
        : context.read<SettingsBloc>().state.settings.autofocusSeconds;

    context.read<SettingsBloc>()
      ..add(AutofocusSecondsChanged(seconds))
      ..add(AutofocusEnabledToggled(_pendingEnabled));

    context.pop();
  }

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
              child: SizedBox(
                width: 360,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              '[ BACK ]',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.dimGreen,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Text('[ SETTINGS ]', style: AppTextStyles.headerText),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '> AUTOFOCUS',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.neonGreen,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _SettingsCheckbox(
                            value: _pendingEnabled,
                            onChanged: (val) =>
                                setState(() => _pendingEnabled = val),
                          ),
                          const SizedBox(width: 16),
                          Text('ENABLED', style: AppTextStyles.label),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            child: TextField(
                              controller: _secondsController,
                              enabled: _pendingEnabled,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textAlign: TextAlign.center,
                              style: AppTextStyles.buttonText,
                              decoration: InputDecoration(
                                isDense: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.neonGreen),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.dimGreen
                                        .withValues(alpha: 0.4),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.neonGreen, width: 2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'SECONDS UNTIL FOCUS',
                            style: AppTextStyles.label.copyWith(
                              color: _pendingEnabled
                                  ? AppColors.dimGreen
                                  : AppColors.dimGreen.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      OutlinedButton(
                        onPressed: _save,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.neonGreen,
                          side: const BorderSide(color: AppColors.neonGreen),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          textStyle: AppTextStyles.buttonText,
                        ),
                        child: const Text('[ SAVE ]'),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neonGreen),
          color: value
              ? AppColors.neonGreen.withValues(alpha: 0.15)
              : Colors.transparent,
        ),
        child: value
            ? const Center(
                child: Text(
                  'X',
                  style: TextStyle(
                    fontFamily: 'CourierPrime',
                    fontSize: 13,
                    color: AppColors.neonGreen,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
