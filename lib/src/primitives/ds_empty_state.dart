import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Empty state with icon, title, and optional subtitle.
class DsEmptyState extends StatelessWidget {
  const DsEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.action,
  });

  final Widget icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(height: AppSpacing.md.h),
            Text(
              title,
              style: AppTextStyles.subheading.copyWith(color: c.contentPrimary),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              SizedBox(height: AppSpacing.xs.h),
              Text(
                subtitle!,
                style: AppTextStyles.body.copyWith(color: c.contentSecondary),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              SizedBox(height: AppSpacing.lg.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading spinner with optional label below.
class DsLoadingSpinner extends StatelessWidget {
  const DsLoadingSpinner({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2.5,
            color: c.accent,
          ),
          if (label != null) ...[
            SizedBox(height: AppSpacing.sm.h),
            Text(
              label!,
              style: AppTextStyles.caption.copyWith(color: c.contentSecondary),
            ),
          ],
        ],
      ),
    );
  }
}
