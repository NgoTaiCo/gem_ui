import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Tokenized switch / toggle.
class DsCustomSwitch extends StatelessWidget {
  const DsCustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: activeColor ?? c.accent,
      inactiveTrackColor: c.divider,
    );
  }
}

/// Menu row with a trailing switch.
class DsMenuItemSwitch extends StatelessWidget {
  const DsMenuItemSwitch({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.leadingIcon,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? subtitle;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md.w,
        vertical: AppSpacing.sm.h,
      ),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: 20.w, color: c.contentSecondary),
            SizedBox(width: AppSpacing.sm.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(color: c.contentPrimary),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: AppTextStyles.caption
                        .copyWith(color: c.contentSecondary),
                  ),
              ],
            ),
          ),
          DsCustomSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// Menu row with a trailing text value.
class DsMenuItemValue extends StatelessWidget {
  const DsMenuItemValue({
    super.key,
    required this.title,
    this.value,
    this.onTap,
    this.leadingIcon,
  });

  final String title;
  final String? value;
  final VoidCallback? onTap;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Material(
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
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 20.w, color: c.contentSecondary),
                SizedBox(width: AppSpacing.sm.w),
              ],
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body.copyWith(color: c.contentPrimary),
                ),
              ),
              if (value != null)
                Text(
                  value!,
                  style: AppTextStyles.body.copyWith(color: c.contentSecondary),
                ),
              SizedBox(width: AppSpacing.xs.w),
              Icon(Icons.chevron_right_rounded,
                  size: 16.w, color: c.contentSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

/// Menu row with a primary label and a secondary subtitle below it.
///
/// Optionally renders a tinted icon badge (`showBackgroundIcon: true`).
class DsMenuItemSubtitle extends StatelessWidget {
  const DsMenuItemSubtitle({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
    this.showBackgroundIcon = false,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
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
              horizontal: AppSpacing.md.w, vertical: AppSpacing.sm.h),
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
                    color: iconColor ?? c.accentMuted,
                    borderRadius: AppRadius.sharp,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor != null ? c.onAccent : c.accent,
                    size: 18.w,
                  ),
                )
              else
                Icon(
                  icon,
                  size: 20.w,
                  color: iconColor ?? c.contentPrimary,
                ),
              AppSpacing.md.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.body.copyWith(
                        color: c.contentPrimary,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: c.contentSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 18.w,
                color: c.contentSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Groups related menu rows with an optional title.
class DsMenuSection extends StatelessWidget {
  const DsMenuSection({
    super.key,
    required this.children,
    this.title,
    this.margin,
  });

  final List<Widget> children;
  final String? title;
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
              EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding.w),
          decoration: BoxDecoration(
            color: c.surfaceRaised,
            border: Border.all(color: c.divider),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: children.asMap().entries.map((entry) {
              final isLast = entry.key == children.length - 1;
              return Column(
                children: [
                  entry.value,
                  if (!isLast)
                    Divider(height: 1, thickness: 1, color: c.divider),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
