import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Compact tokenized settings row.
///
/// Optional trailing widget; shows chevron by default.
/// Supports [isDestructive] (uses [stateError]) and [isDisabled].
class DsSettingsTile extends StatelessWidget {
  const DsSettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.showChevron = true,
    this.isDestructive = false,
    this.isDisabled = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final bool showChevron;
  final bool isDestructive;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    final iconColor = isDisabled
        ? c.disabled
        : isDestructive
            ? c.stateError
            : c.accent;
    final textColor = isDisabled
        ? c.disabled
        : isDestructive
            ? c.stateError
            : c.contentPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
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
                  color: isDestructive
                      ? c.stateError.withValues(alpha: 0.12)
                      : c.accentMuted,
                  borderRadius: AppRadius.sharp,
                ),
                child: Icon(icon, size: 18.w, color: iconColor),
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body.copyWith(color: textColor),
                ),
              ),
              if (trailing != null) trailing!,
              if (showChevron && trailing == null)
                Icon(
                  LucideIcons.chevronRight,
                  size: 16.w,
                  color: c.contentSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
