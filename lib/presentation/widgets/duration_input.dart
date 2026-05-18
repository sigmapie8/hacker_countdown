import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_theme.dart';

class DurationInput extends StatefulWidget {
  final Duration initialValue;
  final ValueChanged<Duration> onChanged;

  const DurationInput({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<DurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<DurationInput> {
  late TextEditingController _hoursCtrl;
  late TextEditingController _minsCtrl;
  late TextEditingController _secsCtrl;

  @override
  void initState() {
    super.initState();
    final d = widget.initialValue;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    _hoursCtrl = TextEditingController(text: h.toString().padLeft(2, '0'));
    _minsCtrl = TextEditingController(text: m.toString().padLeft(2, '0'));
    _secsCtrl = TextEditingController(text: s.toString().padLeft(2, '0'));
    _hoursCtrl.addListener(_notify);
    _minsCtrl.addListener(_notify);
    _secsCtrl.addListener(_notify);
  }

  void _notify() {
    final h = int.tryParse(_hoursCtrl.text) ?? 0;
    final m = int.tryParse(_minsCtrl.text) ?? 0;
    final s = int.tryParse(_secsCtrl.text) ?? 0;
    widget.onChanged(Duration(hours: h, minutes: m, seconds: s));
  }

  @override
  void dispose() {
    _hoursCtrl.dispose();
    _minsCtrl.dispose();
    _secsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TimeField(label: 'HH', controller: _hoursCtrl, max: 99),
        _Separator(),
        _TimeField(label: 'MM', controller: _minsCtrl, max: 59),
        _Separator(),
        _TimeField(label: 'SS', controller: _secsCtrl, max: 59),
      ],
    );
  }
}

class _TimeField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int max;

  const _TimeField({
    required this.label,
    required this.controller,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 2,
            onTap: () {
              controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: controller.text.length,
              );
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _MaxValueFormatter(max),
            ],
            style: AppTextStyles.timerDisplay.copyWith(
              fontSize: 36,
              letterSpacing: 2,
            ),
            decoration: const InputDecoration(
              counterText: '',
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.label),
        ],
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        ':',
        style: AppTextStyles.timerDisplay.copyWith(fontSize: 36),
      ),
    );
  }
}

class _MaxValueFormatter extends TextInputFormatter {
  final int max;
  const _MaxValueFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final val = int.tryParse(newValue.text);
    if (val == null || val > max) return oldValue;
    return newValue;
  }
}
