import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';
import '../primitives/ds_badge.dart';

/// Tokenized menu / settings row with an icon, label, optional count badge,
/// and chevron.
///
/// Set [showBackgroundIcon] to `true` to render the icon inside a coloured
/// 32 dp badge container (accent by default, override with [iconColor]).
/// Set [isWarning] to `true` for destructive actions (text and icon in
/// [stateError] colour).
class DsMenuItem extends StatelessWidget {
  const DsMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isWarning = false,
    this.count,
    this.iconColor,
    this.showBackgroundIcon = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isWarning;
  final int? count;
  final Color? iconColor;
  final bool showBackgroundIcon;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md.w,
            vertical: AppSpacing.sm.h + AppSpacing.xs.h,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: c.divider, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              if (showBackgroundIcon)
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: iconColor ?? c.accent,
                    borderRadius: AppRadius.sharp,
                  ),
                  child: Icon(icon, color: c.onAccent, size: 20.w),
                )
              else
                Icon(
                  icon,
                  color: isWarning
                      ? c.stateError
                      : (iconColor ?? c.contentPrimary),
                  size: 20.w,
                ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isWarning ? c.stateError : c.contentSecondary,
                  ),
                ),
              ),
              if (count != null && count! > 0) ...[
                SizedBox(width: AppSpacing.sm.w),
                DsBadge.count(count: count!),
                SizedBox(width: AppSpacing.sm.w),
              ],
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
