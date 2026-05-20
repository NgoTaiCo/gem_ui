import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/shadows.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Generic list row: icon badge + label + optional trailing widget.
///
/// Replaces raw menu rows throughout the app.
class DsFlatRow extends StatelessWidget {
  const DsFlatRow({
    super.key,
    required this.icon,
    required this.label,
    this.subtitle,
    this.trailing,
    this.showChevron = true,
    this.onTap,
    this.iconColor,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;
  final Color? iconColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md.w,
                vertical: AppSpacing.sm.h + 2.h,
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: (iconColor ?? c.accent).withValues(alpha: 0.12),
                      borderRadius: AppRadius.sharp,
                    ),
                    child: Icon(
                      icon,
                      size: 18.w,
                      color: iconColor ?? c.accent,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: AppTextStyles.body
                              .copyWith(color: c.contentPrimary),
                        ),
                        if (subtitle != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            subtitle!,
                            style: AppTextStyles.caption
                                .copyWith(color: c.contentSecondary),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                  if (showChevron && trailing == null)
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18.w,
                      color: c.contentSecondary,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding:
                EdgeInsets.only(left: (AppSpacing.md + 36 + AppSpacing.md).w),
            child: Divider(height: 1, thickness: 1, color: c.divider),
          ),
      ],
    );
  }
}

/// A titled section card shell that groups [DsFlatRow] items.
class DsSectionCard extends StatelessWidget {
  const DsSectionCard({
    super.key,
    this.title,
    required this.children,
    this.margin,
  });

  final String? title;
  final List<Widget> children;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenPadding.w,
              AppSpacing.lg.h,
              AppSpacing.screenPadding.w,
              AppSpacing.xs.h,
            ),
            child: Text(
              title!.toUpperCase(),
              style: AppTextStyles.caption.copyWith(
                color: c.contentSecondary,
                letterSpacing: 1.2,
              ),
            ),
          ),
        Container(
          margin: margin ??
              EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding.w,
              ),
          decoration: BoxDecoration(
            color: c.surfaceRaised,
            borderRadius: AppRadius.soft,
            boxShadow: AppShadows.lowLight,
            border: Border.all(color: c.divider),
          ),
          child: ClipRRect(
            borderRadius: AppRadius.soft,
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}
