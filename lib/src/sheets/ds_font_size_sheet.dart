import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Shows the [DsFontSizeSheet].
Future<void> showDsFontSizeSheet(
  BuildContext context, {
  required double fontSize,
  required void Function(double size) onConfirm,
  String title = 'Font Size',
  String cancelLabel = 'Cancel',
  String confirmLabel = 'Apply',
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DsFontSizeSheet(
      fontSize: fontSize,
      onConfirm: onConfirm,
      title: title,
      cancelLabel: cancelLabel,
      confirmLabel: confirmLabel,
    ),
  );
}

/// Tokenized font-size bottom sheet.
///
/// Provides preset size chips + fine-tune slider.
class DsFontSizeSheet extends StatefulWidget {
  const DsFontSizeSheet({
    super.key,
    required this.fontSize,
    required this.onConfirm,
    this.title = 'Font Size',
    this.cancelLabel = 'Cancel',
    this.confirmLabel = 'Apply',
  });

  final double fontSize;
  final void Function(double size) onConfirm;
  final String title;
  final String cancelLabel;
  final String confirmLabel;

  @override
  State<DsFontSizeSheet> createState() => _DsFontSizeSheetState();
}

class _DsFontSizeSheetState extends State<DsFontSizeSheet> {
  static const List<double> _presets = [12, 14, 16, 18, 20];
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _fontSize = widget.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Container(
        decoration: BoxDecoration(
          color: c.surfaceRaised,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: AppSpacing.sm.h),
                // Drag handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: c.divider,
                    borderRadius: AppRadius.circle,
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                // Icon header
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: c.accentMuted,
                    borderRadius: AppRadius.soft,
                  ),
                  child: Icon(LucideIcons.type, size: 22.w, color: c.accent),
                ),
                SizedBox(height: AppSpacing.sm.h),
                Text(
                  widget.title,
                  style: AppTextStyles.subheading
                      .copyWith(color: c.contentPrimary),
                ),
                SizedBox(height: AppSpacing.lg.h),
                // Chat preview
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSpacing.md.w),
                  decoration: BoxDecoration(
                    color: c.surfaceOverlay,
                    borderRadius: AppRadius.soft,
                    border: Border.all(color: c.divider),
                  ),
                  child: Text(
                    'Preview text at ${_fontSize.toStringAsFixed(0)}sp',
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: c.contentPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                // Preset chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _presets.map((size) {
                    final selected = _fontSize == size;
                    return GestureDetector(
                      onTap: () => setState(() => _fontSize = size),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm.w + 2,
                          vertical: AppSpacing.xs.h + 2,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? c.accentMuted : c.inputFill,
                          borderRadius: AppRadius.sharp,
                          border: Border.all(
                            color: selected ? c.accent : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          size.toStringAsFixed(0),
                          style: AppTextStyles.label.copyWith(
                            color: selected ? c.accent : c.contentSecondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: AppSpacing.md.h),
                // Slider
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: c.accent,
                    inactiveTrackColor: c.divider,
                    thumbColor: c.accent,
                    overlayColor: c.accentMuted,
                  ),
                  child: Slider(
                    value: _fontSize,
                    min: 10,
                    max: 24,
                    divisions: 14,
                    onChanged: (v) => setState(() => _fontSize = v),
                  ),
                ),
                SizedBox(height: AppSpacing.md.h),
                // CTA row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: c.contentSecondary,
                          side: BorderSide(color: c.divider),
                          shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.soft),
                          padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.sm.h + 2.h),
                        ),
                        child: Text(
                          widget.cancelLabel,
                          style: AppTextStyles.subheading
                              .copyWith(color: c.contentSecondary),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onConfirm(_fontSize);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c.accent,
                          foregroundColor: c.onAccent,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.soft),
                          padding: EdgeInsets.symmetric(
                              vertical: AppSpacing.sm.h + 2.h),
                        ),
                        child: Text(
                          widget.confirmLabel,
                          style: AppTextStyles.subheading
                              .copyWith(color: c.onAccent),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.md.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
