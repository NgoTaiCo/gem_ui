import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/shadows.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Shared back button for auth-flow screens.
///
/// Padding-only hit area (no container box). Defaults to [Navigator.maybePop].
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({
    super.key,
    this.onTap,
    this.color,
  });

  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return GestureDetector(
      onTap: onTap ?? () => Navigator.maybePop(context),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.sm.w),
        child: Icon(
          Icons.chevron_left_rounded,
          size: 26.w,
          color: color ?? c.contentPrimary,
        ),
      ),
    );
  }
}

/// Asymmetric chat bubble shell.
///
/// Apply [isSent] for outgoing vs incoming style.
class DsChatBubble extends StatelessWidget {
  const DsChatBubble({
    super.key,
    required this.isSent,
    required this.child,
    this.padding,
  });

  final bool isSent;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: AppSpacing.bubblePadding.w + 4,
            vertical: AppSpacing.bubblePadding.h,
          ),
      decoration: BoxDecoration(
        color: isSent ? c.bubbleSent : c.bubbleReceived,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isSent ? 18.r : 4.r),
          topRight: Radius.circular(isSent ? 4.r : 18.r),
          bottomLeft: Radius.circular(18.r),
          bottomRight: Radius.circular(18.r),
        ),
        border: Border.all(
          color: c.divider.withValues(alpha: 0.5),
          width: 0.5,
        ),
        boxShadow: AppShadows.lowLight,
      ),
      child: child,
    );
  }
}

/// Centered text-first system-message shell for neutral/warning/accent events.
class DsChatSystemMessage extends StatelessWidget {
  const DsChatSystemMessage({
    super.key,
    required this.text,
    this.leading,
    this.type = DsSystemMessageType.neutral,
  });

  final String text;
  final Widget? leading;
  final DsSystemMessageType type;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    final Color textColor = switch (type) {
      DsSystemMessageType.neutral => c.contentSecondary,
      DsSystemMessageType.warning => c.stateWarning,
      DsSystemMessageType.accent => c.accent,
    };

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xs.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: AppSpacing.xs.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm.w,
                vertical: 3.h,
              ),
              decoration: BoxDecoration(
                color: c.surfaceOverlay,
                borderRadius: AppRadius.sharp,
              ),
              child: Text(
                text,
                style: AppTextStyles.caption.copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum DsSystemMessageType { neutral, warning, accent }
