import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Fixed-height dashboard header (64px).
///
/// Layout: left slot | truly-centered title | right slot.
/// Used by all dashboard-tab screens.
class DsDashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  const DsDashboardHeader({
    super.key,
    this.leading,
    this.title,
    this.titleWidget,
    this.action,
    this.backgroundColor,
    this.showDivider = true,
  });

  final Widget? leading;
  final String? title;
  final Widget? titleWidget;
  final Widget? action;
  final Color? backgroundColor;
  final bool showDivider;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Container(
      height: preferredSize.height,
      color: backgroundColor ?? c.surfaceRaised,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Left slot
                if (leading != null)
                  Positioned(
                    left: AppSpacing.screenPadding.w,
                    child: leading!,
                  ),
                // Centred title
                Center(
                  child: titleWidget ??
                      (title != null
                          ? Text(
                              title!,
                              style: AppTextStyles.heading
                                  .copyWith(color: c.contentPrimary),
                            )
                          : const SizedBox.shrink()),
                ),
                // Right action
                if (action != null)
                  Positioned(
                    right: AppSpacing.screenPadding.w,
                    child: action!,
                  ),
              ],
            ),
          ),
          if (showDivider) Divider(height: 1, thickness: 1, color: c.divider),
        ],
      ),
    );
  }
}

/// Standard back-arrow app bar for sub-screens.
///
/// Shows a truly-centered title with a [chevron_left] leading icon and an
/// optional right action slot.
class DsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DsAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.action,
    this.onBack,
    this.showDivider = true,
    this.backgroundColor,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? action;
  final VoidCallback? onBack;
  final bool showDivider;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Container(
      height: preferredSize.height,
      color: backgroundColor ?? c.surfaceRaised,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: AppSpacing.xs.w,
                  child: IconButton(
                    icon: Icon(Icons.chevron_left_rounded,
                        size: 26.w, color: c.contentPrimary),
                    onPressed: onBack ?? () => Navigator.maybePop(context),
                    splashRadius: 22,
                  ),
                ),
                Center(
                  child: titleWidget ??
                      (title != null
                          ? Text(
                              title!,
                              style: AppTextStyles.subheading
                                  .copyWith(color: c.contentPrimary),
                            )
                          : const SizedBox.shrink()),
                ),
                if (action != null)
                  Positioned(
                    right: AppSpacing.xs.w,
                    child: action!,
                  ),
              ],
            ),
          ),
          if (showDivider) Divider(height: 1, thickness: 1, color: c.divider),
        ],
      ),
    );
  }
}
