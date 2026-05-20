import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/shadows.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Sticky bottom bar that shows how many items are selected and provides a
/// confirm action.
///
/// Tapping the count area fires [onTapSelected] (e.g. to show a bottom sheet
/// listing the selected items). Pass `null` to make the count area
/// non-interactive.
///
/// All user-visible text is passed in as pre-formatted strings so the widget
/// has no dependency on any localisation package.
///
/// ```dart
/// DsCheckedConfirm(
///   checkedCount: logic.selected.length,
///   selectedCountLabel: '${logic.selected.length} selected',
///   confirmLabel: 'Confirm (${logic.selected.length} / 50)',
///   onTapSelected: () => _showSelectedSheet(context),
///   onConfirm: logic.confirm,
///   enableConfirm: logic.selected.isNotEmpty,
/// )
/// ```
class DsCheckedConfirm extends StatelessWidget {
  const DsCheckedConfirm({
    super.key,
    required this.checkedCount,
    required this.selectedCountLabel,
    required this.confirmLabel,
    required this.onConfirm,
    this.checkedTips,
    this.enableConfirm = true,
    this.onTapSelected,
  });

  /// Raw count used to determine active/inactive colouring of the badge.
  final int checkedCount;

  /// Pre-formatted count label shown in the pill (e.g. "3 selected").
  final String selectedCountLabel;

  /// Pre-formatted confirm button label (e.g. "Confirm (3 / 50)").
  final String confirmLabel;

  /// Optional secondary hint shown below the count badge.
  final String? checkedTips;

  /// Called when the count area is tapped. Pass `null` to disable.
  final VoidCallback? onTapSelected;

  /// Called when the confirm button is tapped.
  final VoidCallback onConfirm;

  /// When `false` the confirm button is rendered in disabled style.
  final bool enableConfirm;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final hasItems = checkedCount > 0;
    final canOpenSheet = hasItems && onTapSelected != null;

    return Container(
      constraints: BoxConstraints(minHeight: 72.h),
      decoration: BoxDecoration(
        color: c.surfaceRaised,
        border: Border(top: BorderSide(width: 0.5, color: c.divider)),
        boxShadow: AppShadows.lowLight,
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenPadding.w,
        AppSpacing.sm.h,
        AppSpacing.screenPadding.w,
        AppSpacing.sm.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Count area
          Expanded(
            flex: 3,
            child: Material(
              color: c.surfaceRaised,
              child: InkWell(
                borderRadius: AppRadius.soft,
                onTap: canOpenSheet ? onTapSelected : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm.w,
                    vertical: AppSpacing.xs.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm.w,
                              vertical: AppSpacing.xs.h,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  hasItems ? c.accentMuted : c.surfaceOverlay,
                              borderRadius: AppRadius.round,
                            ),
                            child: Text(
                              selectedCountLabel,
                              style: AppTextStyles.label.copyWith(
                                color: hasItems ? c.accent : c.contentSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (canOpenSheet) ...[
                            SizedBox(width: AppSpacing.xs.w),
                            Icon(
                              LucideIcons.chevronUp,
                              size: 16.w,
                              color: c.contentSecondary,
                            ),
                          ],
                        ],
                      ),
                      if (hasItems && checkedTips != null) ...[
                        SizedBox(height: AppSpacing.xs.h),
                        Text(
                          checkedTips!,
                          style: AppTextStyles.caption
                              .copyWith(color: c.contentSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          // ── Confirm button
          SizedBox(
            height: (AppSpacing.lg + AppSpacing.md).h,
            child: Material(
              color: enableConfirm ? c.accent : c.surfaceOverlay,
              borderRadius: AppRadius.round,
              child: InkWell(
                borderRadius: AppRadius.round,
                onTap: enableConfirm ? onConfirm : null,
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: 120.w,
                    maxWidth: 176.w,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.round,
                    border: Border.all(
                      width: 0.5,
                      color: enableConfirm ? c.accent : c.divider,
                    ),
                    boxShadow:
                        enableConfirm ? AppShadows.lowLight : AppShadows.none,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.check,
                        size: 14.w,
                        color: enableConfirm ? c.onAccent : c.contentSecondary,
                      ),
                      SizedBox(width: AppSpacing.xs.w),
                      Flexible(
                        child: Text(
                          confirmLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.label.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                enableConfirm ? c.onAccent : c.contentSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
