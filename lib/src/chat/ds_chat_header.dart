import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';
import '../primitives/ds_avatar.dart';

/// Tokenized in-chat header row.
///
/// Layout: [back button] [avatar + online dot] [title + member badge + status
/// badge] [trailing action(s)]
///
/// Used as the `AppBar.title` (or inside a `PreferredSize` wrapper) in
/// `ChatPage`.
class DsChatHeader extends StatelessWidget {
  const DsChatHeader({
    super.key,
    required this.title,
    required this.avatarName,
    required this.onBackTap,
    this.avatarUrl,
    this.isGroup = false,
    this.onTitleTap,
    this.subtitle,
    this.subtitleActive = false,
    this.memberLabel,
    this.trailing,
  });

  /// Chat/group name displayed in the header.
  final String title;

  /// Used as the initials fallback in [DsAvatar].
  final String avatarName;

  /// Optional remote image URL for the avatar.
  final String? avatarUrl;

  /// Set `true` for group chats (group icon fallback in avatar).
  final bool isGroup;

  /// Called when the back button is tapped.
  final VoidCallback onBackTap;

  /// Called when the identity block (avatar + name) is tapped.
  final VoidCallback? onTitleTap;

  /// Status text shown below the title (e.g. "Typing…" or "Online").
  final String? subtitle;

  /// When `true` the subtitle and presence dot are rendered in accent colour.
  final bool subtitleActive;

  /// Compact member-count badge shown next to the title (e.g. "42 members").
  final String? memberLabel;

  /// Optional trailing widget — typically a row of [DsChatHeaderActionButton].
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final cleanSubtitle = subtitle?.trim() ?? '';
    final cleanMemberLabel = memberLabel?.trim() ?? '';
    final hasSubtitle = cleanSubtitle.isNotEmpty;
    final hasMemberLabel = cleanMemberLabel.isNotEmpty;

    return Row(
      children: [
        _BackButton(onTap: onBackTap),
        SizedBox(width: AppSpacing.sm.w),
        Expanded(
          child: GestureDetector(
            onTap: onTitleTap,
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    RepaintBoundary(
                      child: DsAvatar(
                        name: avatarName,
                        faceUrl: avatarUrl,
                        isGroup: isGroup,
                        size: AppSpacing.xl,
                      ),
                    ),
                    if (subtitleActive)
                      PositionedDirectional(
                        end: 0,
                        bottom: 0,
                        child: Container(
                          width: (AppSpacing.md - AppSpacing.xs).w,
                          height: (AppSpacing.md - AppSpacing.xs).w,
                          decoration: BoxDecoration(
                            color: c.presenceOnline,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: c.surfaceRaised,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: AppSpacing.sm.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.subheading.copyWith(
                                color: c.contentPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (hasMemberLabel) ...[
                            SizedBox(width: AppSpacing.xs.w),
                            _InfoBadge(
                              label: cleanMemberLabel,
                              backgroundColor: c.surfaceOverlay,
                              textColor: c.contentSecondary,
                            ),
                          ],
                        ],
                      ),
                      if (hasSubtitle) ...[
                        SizedBox(height: AppSpacing.xs.h),
                        _InfoBadge(
                          label: cleanSubtitle,
                          backgroundColor:
                              subtitleActive ? c.accentMuted : c.surfaceOverlay,
                          textColor:
                              subtitleActive ? c.accent : c.contentSecondary,
                          leading: Icon(
                            LucideIcons.circle,
                            size: 8.w,
                            color: subtitleActive
                                ? c.presenceOnline
                                : c.contentSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: AppSpacing.xs.w),
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.xs.w),
            child: trailing!,
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Action button (circular icon button for trailing slot)
// ─────────────────────────────────────────────────────────────────────────────

/// Circular icon button for the [DsChatHeader] trailing slot.
///
/// Set [isAccent] to highlight the button with the accent fill.
/// Set [onTap] to `null` to disable.
class DsChatHeaderActionButton extends StatelessWidget {
  const DsChatHeaderActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.isAccent = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool isAccent;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final isEnabled = onTap != null;
    final iconColor = !isEnabled
        ? c.disabled
        : isAccent
            ? c.accent
            : c.contentPrimary;
    final backgroundColor = !isEnabled
        ? c.surfaceOverlay
        : isAccent
            ? c.accentMuted
            : c.surfaceOverlay;
    final borderColor = !isEnabled
        ? c.divider
        : isAccent
            ? c.accentMuted
            : c.divider;

    return Material(
      color: c.surface.withValues(alpha: 0),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: AppSpacing.xl.w,
          height: AppSpacing.xl.w,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 0.5),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18.w, color: iconColor),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helpers
// ─────────────────────────────────────────────────────────────────────────────

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    return Material(
      color: c.surface.withValues(alpha: 0),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: AppSpacing.xl.w,
          height: AppSpacing.xl.w,
          child: Icon(
            LucideIcons.chevronLeft,
            size: 22.w,
            color: c.contentPrimary,
          ),
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.leading,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm.w,
        vertical: AppSpacing.xs.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.circle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: AppSpacing.xs.w),
          ],
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
