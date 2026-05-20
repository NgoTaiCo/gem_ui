import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/typography.dart';

/// Tokenized date-picker dialog wrapper.
///
/// Applies GEM DS token colours to the Flutter [DatePickerDialog] via
/// [ThemeData.copyWith].
///
/// Usage — show as a dialog:
/// ```dart
/// final date = await showDialog<DateTime>(
///   context: context,
///   builder: (_) => DsDatePicker(
///     initialDate: DateTime.now(),
///     firstDate: DateTime(2000),
///     lastDate: DateTime(2100),
///   ),
/// );
/// ```
class DsDatePicker extends StatefulWidget {
  const DsDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.helpText,
    this.cancelText,
    this.confirmText,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? helpText;
  final String? cancelText;
  final String? confirmText;

  @override
  State<DsDatePicker> createState() => _DsDatePickerState();
}

class _DsDatePickerState extends State<DsDatePicker> {
  late DateTime _initialDate;

  @override
  void initState() {
    super.initState();
    _initialDate = _clamp(widget.initialDate);
  }

  DateTime _clamp(DateTime v) {
    if (v.isBefore(widget.firstDate)) return widget.firstDate;
    if (v.isAfter(widget.lastDate)) return widget.lastDate;
    return v;
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final base = Theme.of(context);

    final themed = base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: c.accent,
        onPrimary: c.onAccent,
        surface: c.surfaceRaised,
        onSurface: c.contentPrimary,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surfaceRaised,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.soft,
          side: BorderSide(color: c.divider),
        ),
      ),
      textTheme: base.textTheme.copyWith(
        headlineSmall: AppTextStyles.subheading.copyWith(
          color: c.contentPrimary,
          fontSize: 20.sp,
        ),
        bodyLarge: AppTextStyles.body.copyWith(color: c.contentPrimary),
        bodyMedium: AppTextStyles.body.copyWith(color: c.contentPrimary),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.accent,
          textStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );

    return Theme(
      data: themed,
      child: DatePickerDialog(
        initialDate: _initialDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        helpText: widget.helpText,
        cancelText: widget.cancelText,
        confirmText: widget.confirmText,
      ),
    );
  }
}
