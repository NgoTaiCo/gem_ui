import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Small label / pill-style tag.
class DsLabel extends StatelessWidget {
  const DsLabel({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm.w,
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? c.accentMuted,
        borderRadius: AppRadius.sharp,
      ),
      child: Text(
        text,
        style: AppTextStyles.label.copyWith(
          color: textColor ?? c.accent,
        ),
      ),
    );
  }
}
