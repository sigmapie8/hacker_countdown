import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../core/theme/app_theme.dart';

class _MatrixColumn {
  final double x;
  double y;
  final double speed;
  final int length;
  final List<String> chars;

  _MatrixColumn({
    required this.x,
    required this.y,
    required this.speed,
    required this.length,
    required this.chars,
  });
}

String _randomChar(math.Random rng) {
  // Mix katakana and ASCII digits for the classic look
  if (rng.nextBool()) {
    return String.fromCharCode(0x30A0 + rng.nextInt(0x60));
  }
  return String.fromCharCode(0x30 + rng.nextInt(10));
}

class _MatrixRainPainter extends CustomPainter {
  final List<_MatrixColumn> columns;
  static const double charHeight = 16.0;
  static const double fontSize = 13.0;

  const _MatrixRainPainter(this.columns);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black,
    );

    for (final col in columns) {
      for (int i = 0; i < col.length; i++) {
        final charY = col.y - i * charHeight;
        if (charY < -charHeight || charY > size.height + charHeight) continue;

        final double brightness;
        final Color color;
        if (i == 0) {
          brightness = 1.0;
          color = Colors.white.withValues(alpha: 0.95);
        } else {
          brightness = (1.0 - i / col.length) * 0.85;
          color = i < 3
              ? AppColors.neonGreen.withValues(alpha: brightness)
              : AppColors.dimGreen.withValues(alpha: brightness * 0.7);
        }

        final tp = TextPainter(
          text: TextSpan(
            text: col.chars[i % col.chars.length],
            style: TextStyle(
              fontFamily: AppTextStyles.fontFamily,
              fontSize: fontSize,
              color: color,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, Offset(col.x, charY));
      }
    }
  }

  @override
  bool shouldRepaint(_MatrixRainPainter oldDelegate) => true;
}

class MatrixRainBackground extends StatefulWidget {
  const MatrixRainBackground({super.key});

  @override
  State<MatrixRainBackground> createState() => _MatrixRainBackgroundState();
}

class _MatrixRainBackgroundState extends State<MatrixRainBackground> {
  List<_MatrixColumn> _columns = [];
  Ticker? _ticker;
  DateTime _lastFrame = DateTime.now();
  final math.Random _rng = math.Random();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onTick)..start();
  }

  void _initColumns(Size size) {
    const colSpacing = 16.0;
    final count = (size.width / colSpacing).ceil() + 1;
    _columns = List.generate(count, (i) {
      final length = 5 + _rng.nextInt(21);
      return _MatrixColumn(
        x: i * colSpacing,
        y: _rng.nextDouble() * size.height,
        speed: 60 + _rng.nextDouble() * 120,
        length: length,
        chars: List.generate(length + 5, (_) => _randomChar(_rng)),
      );
    });
    _initialized = true;
  }

  void _onTick(Duration _) {
    final now = DateTime.now();
    final dt = now.difference(_lastFrame).inMilliseconds / 1000.0;
    _lastFrame = now;

    if (!_initialized || _columns.isEmpty) return;

    final size = context.size;
    if (size == null) return;

    for (final col in _columns) {
      col.y += col.speed * dt;
      if (col.y > size.height + col.length * 16.0) {
        col.y = -_rng.nextDouble() * size.height * 0.5;
        // Randomize chars on reset for variety
        for (int i = 0; i < col.chars.length; i++) {
          col.chars[i] = _randomChar(_rng);
        }
      }
      // Occasionally mutate a random char in the trail
      if (_rng.nextInt(10) == 0) {
        final idx = _rng.nextInt(col.chars.length);
        col.chars[idx] = _randomChar(_rng);
      }
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        if (!_initialized && size.width > 0 && size.height > 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _initColumns(size);
            }
          });
        }
        return CustomPaint(
          painter: _MatrixRainPainter(_columns),
          size: size,
        );
      },
    );
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }
}
