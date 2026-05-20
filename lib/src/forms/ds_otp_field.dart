import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// 4-box OTP / PIN input field.
///
/// Provides a row of [length] separated boxes, each accepting one digit.
/// Calls [onCompleted] when all boxes are filled.
class DsOtpField extends StatefulWidget {
  const DsOtpField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
  });

  final int length;
  final void Function(String code)? onCompleted;
  final void Function(String code)? onChanged;

  @override
  State<DsOtpField> createState() => _DsOtpFieldState();
}

class _DsOtpFieldState extends State<DsOtpField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _currentCode => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.length > 1) {
      // Handle paste — distribute across boxes.
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
      for (var i = 0; i < digits.length && index + i < widget.length; i++) {
        final controller = _controllers[index + i];
        controller.text = digits[i];
        controller.selection = const TextSelection.collapsed(offset: 1);
      }
      final filledUntil =
          (index + digits.length - 1).clamp(0, widget.length - 1);
      if (filledUntil == widget.length - 1) {
        _nodes[filledUntil].unfocus();
      } else {
        _nodes[filledUntil + 1].requestFocus();
      }
    } else if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _nodes[index + 1].requestFocus();
      } else {
        _nodes[index].unfocus();
      }
    }

    final code = _currentCode;
    widget.onChanged?.call(code);
    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        final isLast = i == widget.length - 1;
        return Row(
          children: [
            _buildBox(c, i),
            if (!isLast) SizedBox(width: AppSpacing.sm.w),
          ],
        );
      }),
    );
  }

  Widget _buildBox(AppColorTokens c, int index) {
    return SizedBox(
      width: 48.w,
      height: 56.h,
      child: AnimatedBuilder(
        animation: _nodes[index],
        builder: (_, __) {
          final isFocused = _nodes[index].hasFocus;
          return Container(
            decoration: BoxDecoration(
              color: c.inputFill,
              borderRadius: AppRadius.soft,
              border: Border.all(
                color: isFocused ? c.accent : c.divider,
                width: isFocused ? 2 : 1,
              ),
            ),
            child: TextField(
              controller: _controllers[index],
              focusNode: _nodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: AppTextStyles.heading.copyWith(color: c.contentPrimary),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (v) => _onDigitChanged(index, v),
            ),
          );
        },
      ),
    );
  }
}
