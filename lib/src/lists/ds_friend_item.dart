import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../primitives/ds_avatar.dart';
import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Plain data struct for [DsFriendItem].
/// Decouples the widget from SDK model types (ISUserInfo / UserFullInfo).
class DsFriendItemData {
  final String userId;
  final String showName;
  final String? faceUrl;

  /// Remark set by the current user (alias). When non-null, [nickname] is
  /// shown below as the person's original display name.
  final String? remark;
  final String? nickname;

  const DsFriendItemData({
    required this.userId,
    required this.showName,
    this.faceUrl,
    this.remark,
    this.nickname,
  });
}

/// Tokenized friend / contact list row.
///
/// Supports checkbox selection, call/chat action buttons, and keyword
/// highlighting (caller provides [keyText] for substring match).
class DsFriendItem extends StatelessWidget {
  const DsFriendItem({
    super.key,
    required this.info,
    this.showDivider = true,
    this.checked,
    this.enabled,
    this.onTap,
    this.showRadioButton,
    this.padding,
    this.showCall = false,
    this.showChat = false,
    this.onCall,
    this.onChat,
    this.backgroundColor,
  });

  final DsFriendItemData info;
  final bool showDivider;
  final bool? checked;
  final bool? enabled;
  final VoidCallback? onTap;
  final bool? showRadioButton;
  final EdgeInsets? padding;
  final bool showCall;
  final bool showChat;
  final VoidCallback? onCall;
  final VoidCallback? onChat;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final isEnabled =
        (enabled ?? false) || (checked == null && enabled == null);

    return Material(
      color: backgroundColor ?? c.surfaceRaised,
      borderRadius: AppRadius.soft,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        child: Padding(
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
          child: Row(
            children: [
              DsAvatar(
                name: info.showName,
                faceUrl: info.faceUrl,
                size: 44,
              ),
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      info.showName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                        color: c.contentPrimary,
                      ),
                    ),
                    if ((info.remark?.isNotEmpty ?? false) &&
                        (info.nickname?.isNotEmpty ?? false)) ...[
                      SizedBox(height: 2.h),
                      Text(
                        info.nickname!,
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
              if (showCall || showChat)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showChat)
                        _ActionButton(
                          icon: LucideIcons.messageCircle,
                          color: c.accent,
                          onTap: onChat,
                        ),
                      if (showCall) ...[
                        SizedBox(width: AppSpacing.xs.w),
                        _ActionButton(
                          icon: LucideIcons.phone,
                          color: c.accent,
                          onTap: onCall,
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
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16.w, color: color),
      ),
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
      child: isChecked
          ? Icon(LucideIcons.check, size: 12.w, color: c.onAccent)
          : null,
    );
  }
}
