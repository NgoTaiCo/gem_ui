import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../primitives/ds_avatar.dart';
import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/shadows.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Plain data struct for [DsGroupItem].
/// Decouples the widget from SDK model types (GroupInfo from flutter_openim_sdk).
class DsGroupItemData {
  final String groupId;
  final String groupName;
  final String? faceUrl;
  final int? memberCount;

  const DsGroupItemData({
    required this.groupId,
    required this.groupName,
    this.faceUrl,
    this.memberCount,
  });
}

/// Tokenized group list card.
///
/// Elevated card with avatar, group name, optional member count, and
/// checkbox selection support.
class DsGroupItem extends StatelessWidget {
  const DsGroupItem({
    super.key,
    required this.info,
    this.showMemberCount = true,
    this.showDivider = false,
    this.onTap,
    this.checked,
    this.enabled,
    this.showRadioButton,
    this.backgroundColor,
    this.memberCountLabel = 'members',
  });

  final DsGroupItemData info;
  final bool showMemberCount;
  final bool showDivider;
  final VoidCallback? onTap;
  final bool? checked;
  final bool? enabled;
  final bool? showRadioButton;
  final Color? backgroundColor;

  /// Localised label for member count suffix, e.g. "members" or "người".
  final String memberCountLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final isEnabled =
        (enabled ?? false) || (checked == null && enabled == null);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(top: AppSpacing.sm.h),
          decoration: BoxDecoration(
            color: backgroundColor ?? c.surfaceRaised,
            borderRadius: AppRadius.soft,
            border: Border.all(color: c.divider, width: 0.5),
            boxShadow: AppShadows.lowLight,
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: AppRadius.soft,
            child: InkWell(
              borderRadius: AppRadius.soft,
              onTap: isEnabled ? onTap : null,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.md.w,
                  AppSpacing.sm.h + AppSpacing.xs.h,
                  AppSpacing.md.w,
                  AppSpacing.md.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DsAvatar(
                      name: info.groupName,
                      faceUrl: info.faceUrl,
                      size: 44,
                      isGroup: true,
                    ),
                    SizedBox(width: AppSpacing.md.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            info.groupName.isEmpty ? '-' : info.groupName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.subheading.copyWith(
                              color: c.contentPrimary,
                            ),
                          ),
                          if (info.groupId.isNotEmpty) ...[
                            SizedBox(height: AppSpacing.xs.h),
                            Text(
                              'ID: ${info.groupId}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.caption.copyWith(
                                color: c.contentSecondary,
                              ),
                            ),
                          ],
                          if (showMemberCount &&
                              (info.memberCount ?? 0) > 0) ...[
                            SizedBox(height: AppSpacing.xs.h),
                            Text(
                              '${info.memberCount} $memberCountLabel',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.caption.copyWith(
                                color: c.contentSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (showRadioButton == true) ...[
                      SizedBox(width: AppSpacing.sm.w),
                      _CheckIndicator(checked: checked, c: c),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CheckIndicator extends StatelessWidget {
  const _CheckIndicator({required this.checked, required this.c});
  final bool? checked;
  final AppColorTokens c;

  @override
  Widget build(BuildContext context) {
    final isChecked = checked ?? false;
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isChecked ? c.accent : Colors.transparent,
        border: Border.all(
          color: isChecked ? c.accent : c.divider,
          width: 1.5,
        ),
      ),
    );
  }
}
